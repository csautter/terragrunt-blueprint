include "root" {
  path = find_in_parent_folders()
}

dependency "kubernetes" {
  config_path = "${get_terragrunt_dir()}/../../dev/kubernetes_ske"
}

include "env" {
  path   = "${get_terragrunt_dir()}/../../_env/kubernetes_generic_provider_example.hcl"
  expose = true
}

include "provider_kubernetes_generic_config" {
  path   = "${get_terragrunt_dir()}/../../_env/provider_kubernetes_generic_config.hcl"
  expose = true
}

inputs = {
}