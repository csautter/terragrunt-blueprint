resource "azurerm_storage_account" "this" {
  name                              = "${var.storage_account_name}${replace(var.env, "_", "")}"
  resource_group_name               = azurerm_resource_group.state.name
  location                          = data.azurerm_location.this.location
  account_tier                      = "Standard"
  account_replication_type          = "LRS"
  infrastructure_encryption_enabled = true

  tags = {
    shortname = var.storage_account_name
    env       = var.env
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_storage_encryption_scope" "this" {
  name               = "defaultencryptionscope"
  storage_account_id = azurerm_storage_account.this.id
  source             = "Microsoft.Storage"

  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_storage_container" "this" {
  name                  = "${var.container_name}${replace(var.env, "_", "")}"
  storage_account_id    = azurerm_storage_account.this.id
  container_access_type = "private"

  lifecycle {
    prevent_destroy = true
  }
}
