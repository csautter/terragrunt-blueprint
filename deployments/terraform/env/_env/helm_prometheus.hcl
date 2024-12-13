locals {
  env_local = try(read_terragrunt_config(find_in_parent_folders("env_local.hcl")), { locals = {} })
  env       = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  config = merge(
    local.env.locals,
    local.env_local.locals
  )
}

terraform {
  source = "tfr://registry.terraform.io/terraform-module/release/helm?version=2.8.2"
}

generate "tflint" {
  path      = "./.tflint.hcl"
  if_exists = "overwrite"
  contents  = file("${get_terragrunt_dir()}/.tflint.hcl")
}

inputs = {
  namespace = "prometheus"

  app = {
    name             = "prometheus"
    chart            = "prometheus"
    version          = "26.0.0"
    deploy           = 1
    create_namespace = true
  }

  repository = "https://prometheus-community.github.io/helm-charts"
}