resource "stackit_key_pair" "keypair" {
  name       = "default-keypair"
  public_key = chomp(file(local.ssh_public_key_path))
}

resource "stackit_server" "bench" {
  for_each          = local.compute_engine_servers_sku_map_filtered_test
  project_id        = var.project_id
  availability_zone = local.current_availability_zone
  boot_volume = {
    source_type = "volume"
    source_id   = stackit_volume.bench[each.key].volume_id
  }
  name         = "bench-${replace(var.env, "_", "-")}-${each.value["attributes"]["flavor"]}"
  machine_type = each.value["attributes"]["flavor"]
  keypair_name = stackit_key_pair.keypair.name
  user_data    = file("${path.module}/cloud-init.yaml")
}

resource "stackit_volume" "bench" {
  for_each          = local.compute_engine_servers_sku_map_filtered_test
  project_id        = var.project_id
  name              = "bench-${replace(var.env, "_", "-")}-${each.value["attributes"]["flavor"]}"
  availability_zone = local.current_availability_zone
  size              = 64
  performance_class = local.boot_volume_performance_class
  source = {
    type = "image"
    # ARM64 Ubuntu 24.04 -> 088dbb82-3512-40d7-bc47-6ee4f64ae2d5
    # x86_64 Ubuntu 24.04 -> 59838a89-51b1-4892-b57f-b3caf598ee2f
    id = each.value["attributes"]["hardware"] == "ARM" ? "088dbb82-3512-40d7-bc47-6ee4f64ae2d5" : "59838a89-51b1-4892-b57f-b3caf598ee2f"
  }
  labels = {
    "env" = var.env
    "app" = "benchmark"
  }
}

resource "null_resource" "provision_pts" {
  for_each = local.compute_engine_servers_sku_map_filtered_test

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file(local.ssh_private_key_path)
    host        = stackit_public_ip.public_ip[each.key].ip
  }

  provisioner "file" {
    source      = "${path.module}/phoronix-test-suite.xml"
    destination = "/tmp/phoronix-test-suite.xml"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mv /tmp/phoronix-test-suite.xml /etc/phoronix-test-suite.xml",
      "sudo git clone -b feat/cost_calculation_precision --depth=1 https://github.com/csautter/phoronix-test-suite.git /opt/phoronix-test-suite",
      "cd /opt/phoronix-test-suite && sudo bash /opt/phoronix-test-suite/install-sh",
      "sudo apt-get update",
      "sudo apt-get install -y php-cli php-xml",
      "sudo TEST_RESULTS_NAME=stackit_${local.current_availability_zone}_${each.value["attributes"]["flavor"]}_${timestamp()} TEST_RESULTS_IDENTIFIER=stackit_${local.current_availability_zone}_${each.value["attributes"]["flavor"]} FORCE_TIMES_TO_RUN=1 TOTAL_LOOP_TIME=1 COST_PERF_PER_UNIT=\"euro/hour\" COST_PERF_PER_DOLLAR=${each.value["price"]} phoronix-test-suite batch-benchmark nginx apache node-web-tooling redis phpbench pybench scikit-learn stress-ng"
    ]
  }

  provisioner "local-exec" {
    command = "mkdir -p ${path.module}/phoronix-test-results/ && scp -r -o StrictHostKeyChecking=no -i ${local.ssh_private_key_path} ubuntu@${stackit_public_ip.public_ip[each.key].ip}:/var/lib/phoronix-test-suite/test-results/* ${path.module}/phoronix-test-results/"
  }
}

resource "local_file" "extended_benchmark_info" {
  for_each = local.compute_engine_servers_sku_map_filtered_test

  content  = jsonencode(each.value)
  filename = "${path.module}/bench/${plantimestamp()}-${local.availability_zones[0]}-${each.value["attributes"]["flavor"]}_extended.json"
}

resource "stackit_network" "network" {
  project_id         = var.project_id
  name               = "bench-network"
  ipv4_nameservers   = ["1.1.1.1", "8.8.8.8"]
  ipv4_prefix_length = 24
}

resource "stackit_network_interface" "nic" {
  for_each           = local.compute_engine_servers_sku_map_filtered_test
  project_id         = var.project_id
  network_id         = stackit_network.network.network_id
  security_group_ids = [stackit_security_group.this.security_group_id]
}

resource "stackit_public_ip" "public_ip" {
  for_each             = local.compute_engine_servers_sku_map_filtered_test
  project_id           = var.project_id
  network_interface_id = stackit_network_interface.nic[each.key].network_interface_id
}

resource "stackit_server_network_interface_attach" "nic_attachment" {
  for_each             = local.compute_engine_servers_sku_map_filtered_test
  project_id           = var.project_id
  server_id            = stackit_server.bench[each.key].server_id
  network_interface_id = stackit_network_interface.nic[each.key].network_interface_id
}

resource "stackit_security_group" "this" {
  project_id = var.project_id
  name       = "benchmark-security-group"
  stateful   = true
}

resource "stackit_security_group_rule" "this" {
  project_id        = var.project_id
  security_group_id = stackit_security_group.this.security_group_id
  direction         = "ingress"
  ether_type        = "IPv4"
}