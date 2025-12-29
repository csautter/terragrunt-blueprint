resource "azurerm_resource_group" "dummy" {
  name     = "dummy-rg-${var.env}"
  location = data.azurerm_location.east_us.location
  tags = {
    shortname = "dummy"
    env       = var.env
  }
}

data "azurerm_location" "east_us" {
  location = "East US"
}
