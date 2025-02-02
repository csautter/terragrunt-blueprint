terraform {
  required_version = ">= 1.8.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.15.0"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 3.2.2"
    }
  }
}