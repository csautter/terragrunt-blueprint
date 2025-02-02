locals {
  env_local = try(read_terragrunt_config(find_in_parent_folders("env_local.hcl")), { locals = {} })
  env       = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  config = merge(
    local.env.locals,
    local.env_local.locals
  )
}

terraform {
  source = "${get_terragrunt_dir()}/../../../modules//stackit_benchmark"
}

inputs = {
  env                             = local.config.env
  project_id                      = local.config.project_id
  compute_engine_flavor_blacklist = local.config.compute_engine_flavor_blacklist
}