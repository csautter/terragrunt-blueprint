include "root" {
  path = find_in_parent_folders()
}

include "env" {
  path   = "${get_terragrunt_dir()}/../../_env/azure_benchmark.hcl"
  expose = true
}

include "provider_azure_config" {
  path   = "${get_terragrunt_dir()}/../../_env/provider_azure_config.hcl"
  expose = true
}

inputs = {
}