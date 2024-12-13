include "root" {
  path = find_in_parent_folders()
}

include "env" {
  path   = "${get_terragrunt_dir()}/../../_env/helm_prometheus.hcl"
  expose = true
}

include "provider_helm_generic_config" {
  path   = "${get_terragrunt_dir()}/../../_env/provider_helm_generic_config.hcl"
  expose = true
}

inputs = {
}