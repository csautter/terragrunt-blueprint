locals {
  env = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

terraform {
  source = "${get_terragrunt_dir()}/../../../modules//stackit_dummy"
}

inputs = {
  env        = local.env.locals.env
  project_id = local.env.locals.project_id
}