locals {
  env_local = try(read_terragrunt_config(find_in_parent_folders("env_local.hcl")), { locals = {} })
  env       = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  config = merge(
    local.env.locals,
    local.env_local.locals
  )
}

dependency "kubernetes_cluster" {
  config_path = "${get_terragrunt_dir()}/../../${local.config.env}/kubernetes_ske"
}

generate "provider_kubernetes" {
  path      = "provider_kubernetes_generic.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<-EOF
    provider "kubernetes" {
      host                   = "${dependency.kubernetes_cluster.outputs.cluster_endpoint}"
      cluster_ca_certificate = base64decode("${dependency.kubernetes_cluster.outputs.cluster_ca_certificate}")
      client_certificate     = base64decode("${dependency.kubernetes_cluster.outputs.client_certificate}")
      client_key             = base64decode("${dependency.kubernetes_cluster.outputs.client_key}")
    }
    EOF
}
