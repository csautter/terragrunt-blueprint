resource "azurerm_resource_group" "benchmark" {
  name     = "benchmark"
  location = "Germany West Central"
}

data "azurerm_location" "west_europe" {
  location = "Germany West Central"
}

resource "azurerm_virtual_network" "benchmark" {
  name                = "benchmark-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.benchmark.location
  resource_group_name = azurerm_resource_group.benchmark.name
}

resource "azurerm_subnet" "benchmark" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.benchmark.name
  virtual_network_name = azurerm_virtual_network.benchmark.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "benchmark" {
  for_each            = toset(local.machine_types)
  name                = "benchmark-public-ip-${each.key}"
  location            = azurerm_resource_group.benchmark.location
  resource_group_name = azurerm_resource_group.benchmark.name
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "benchmark" {
  for_each            = toset(local.machine_types)
  name                = "benchmark-nic-${each.key}"
  location            = azurerm_resource_group.benchmark.location
  resource_group_name = azurerm_resource_group.benchmark.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.benchmark.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.benchmark[each.key].id
  }
}

resource "azurerm_linux_virtual_machine" "benchmark" {
  for_each            = toset(local.machine_types)
  name                = "benchmark-machine-${replace(each.key, "_", "-")}"
  resource_group_name = azurerm_resource_group.benchmark.name
  location            = azurerm_resource_group.benchmark.location
  zone                = data.azurerm_location.west_europe.zone_mappings[0].logical_zone
  size                = each.value
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.benchmark[each.key].id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file(local.ssh_public_key_path)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  # https://documentation.ubuntu.com/azure/en/latest/azure-how-to/instances/find-ubuntu-images/
  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server-gen1"
    version   = "latest"
  }
}

resource "null_resource" "provision_pts" {
  for_each = azurerm_linux_virtual_machine.benchmark

  connection {
    type        = "ssh"
    user        = "adminuser"
    private_key = file(local.ssh_private_key_path)
    host        = azurerm_public_ip.benchmark[each.key].ip_address
  }

  provisioner "file" {
    source      = "${path.module}/phoronix-test-suite.xml"
    destination = "/tmp/phoronix-test-suite.xml"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get -o DPkg::Lock::Timeout=300 update",
      "sudo apt-get -o DPkg::Lock::Timeout=300 install -y php-cli php-xml unzip curl wget vim locales jq git make",
      "sudo mv /tmp/phoronix-test-suite.xml /etc/phoronix-test-suite.xml",
      "sudo git clone -b feat/cost_calculation_precision --depth=1 https://github.com/csautter/phoronix-test-suite.git /opt/phoronix-test-suite",
      "cd /opt/phoronix-test-suite && sudo bash /opt/phoronix-test-suite/install-sh",
      "export COST_PERF_PER_DOLLAR=$(curl -sG https://prices.azure.com/api/retail/prices --data-urlencode \"currencyCode=EUR\" --data-urlencode \"\\$filter=serviceName eq 'Virtual Machines' and armRegionName eq 'germanywestcentral' and armSkuName eq '${each.value.size}' and priceType eq 'Consumption'\" | jq -r \".Items[] | select(all(.skuName; contains(\\\"Spot\\\") | not)) | select(all(.productName; contains(\\\"Windows\\\") | not)) | select(all(.meterName; contains(\\\"Low\\\") | not)) | select(all(.productName; contains(\\\"Virtual Machines\\\"))) | .unitPrice\")",
      "echo \"COST_PERF_PER_DOLLAR=$COST_PERF_PER_DOLLAR\"",
      "sudo TEST_RESULTS_NAME=\"azure_${data.azurerm_location.west_europe.zone_mappings[0].physical_zone}_${each.value.size}_${timestamp()}\" TEST_RESULTS_IDENTIFIER=\"azure_${data.azurerm_location.west_europe.zone_mappings[0].physical_zone}_${each.value.size}\" FORCE_TIMES_TO_RUN=1 TOTAL_LOOP_TIME=1 COST_PERF_PER_UNIT=\"euro/hour\" COST_PERF_PER_DOLLAR=$COST_PERF_PER_DOLLAR phoronix-test-suite batch-benchmark nginx apache redis pts/stress-ng-1.13.0"
    ]
  }

  provisioner "local-exec" {
    command = "mkdir -p ${path.module}/phoronix-test-results/ && scp -r -o StrictHostKeyChecking=no -i ${local.ssh_private_key_path} adminuser@${azurerm_public_ip.benchmark[each.key].ip_address}:/var/lib/phoronix-test-suite/test-results/* ${path.module}/phoronix-test-results/"
  }
}