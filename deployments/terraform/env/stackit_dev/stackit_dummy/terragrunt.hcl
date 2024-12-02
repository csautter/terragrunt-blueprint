include "root" {
  path = find_in_parent_folders()
}

include "env" {
  path   = "${get_terragrunt_dir()}/../../_env/stackit_dummy.hcl"
  expose = true
}

include "provider_stackit_config" {
  path   = "${get_terragrunt_dir()}/../../_env/provider_stackit_config.hcl"
  expose = true
}

inputs = {
}