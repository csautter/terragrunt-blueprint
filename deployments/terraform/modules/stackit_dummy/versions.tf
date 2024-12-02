terraform {
  required_version = ">= 1.8.0"
  required_providers {
    stackit = {
      source  = "stackitcloud/stackit"
      version = ">= 0.35.0"
    }
  }
}