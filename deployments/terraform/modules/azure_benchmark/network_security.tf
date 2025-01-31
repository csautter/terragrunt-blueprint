resource "azurerm_network_security_group" "benchmark" {
  name                = "benchmark-nsg"
  location            = azurerm_resource_group.benchmark.location
  resource_group_name = azurerm_resource_group.benchmark.name
}

resource "azurerm_network_security_rule" "allow_ssh_inbound" {
  name                        = "allow-ssh-inbound"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  network_security_group_name = azurerm_network_security_group.benchmark.name
  resource_group_name         = azurerm_resource_group.benchmark.name
}

resource "azurerm_network_security_rule" "allow_outbound" {
  name                        = "allow-outbound"
  priority                    = 200
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "Internet"
  network_security_group_name = azurerm_network_security_group.benchmark.name
  resource_group_name         = azurerm_resource_group.benchmark.name
}

resource "azurerm_subnet_network_security_group_association" "benchmark" {
  subnet_id                 = azurerm_subnet.benchmark.id
  network_security_group_id = azurerm_network_security_group.benchmark.id
}