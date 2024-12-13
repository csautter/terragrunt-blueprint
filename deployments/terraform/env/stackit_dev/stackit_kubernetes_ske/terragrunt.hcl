include "root" {
  path = find_in_parent_folders()
}

include "env" {
  path   = "${get_terragrunt_dir()}/../../_env/stackit_kubernetes_ske.hcl"
  expose = true
}

include "provider_stackit_config" {
  path   = "${get_terragrunt_dir()}/../../_env/provider_stackit_config.hcl"
  expose = true
}

locals {
  env_local = try(read_terragrunt_config(find_in_parent_folders("env_local.hcl")), { locals = {} })
  env       = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  config = merge(
    local.env.locals,
    local.env_local.locals
  )
}

inputs = {
  cluster_name = "ske-${local.config.env}"
}