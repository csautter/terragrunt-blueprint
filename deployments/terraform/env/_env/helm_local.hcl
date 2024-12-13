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
  namespace = "default"

  repository = ""

  app = {
    name             = "local"
    chart            = "${get_repo_root()}/deployments/helm/local"
    version          = "0.0.1"
    deploy           = 1
    create_namespace = false
  }

  values = [templatefile("${get_terragrunt_dir()}/values.yaml", {
    env = local.env.locals.env
  })]

  set = [
    {
      name : "resources.limits.cpu"
      value : "500m"
    },
    {
      name : "resources.limits.memory"
      value : "1G"
    },
    {
      name : "resources.requests.cpu"
      value : "500m"
    },
    {
      name : "resources.requests.memory"
      value : "1G"
    }
  ]
}