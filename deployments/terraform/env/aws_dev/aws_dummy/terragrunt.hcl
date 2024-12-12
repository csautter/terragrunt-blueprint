include "root" {
  path = find_in_parent_folders()
}

include "env" {
  path   = "${get_terragrunt_dir()}/../../_env/aws_dummy.hcl"
  expose = true
}

include "provider_aws_config" {
  path   = "${get_terragrunt_dir()}/../../_env/provider_aws_config.hcl"
  expose = true
}

inputs = {
}