terraform {
  required_version = ">= 1.8.0"
  required_providers {
    stackit = {
      source  = "stackitcloud/stackit"
      version = ">= 0.36.0"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 3.2.2"
    }
  }
}