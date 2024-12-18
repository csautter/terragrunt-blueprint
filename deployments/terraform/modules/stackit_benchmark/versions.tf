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
    http = {
      source  = "hashicorp/http"
      version = ">= 3.4.5"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 2.5.2"
    }
  }
}