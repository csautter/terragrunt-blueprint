locals {
  env = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

generate "stackit" {
  path      = "provider_stackit.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<-EOF
     provider "stackit" {
        region  = "${local.env.locals.region}"
        service_account_key = "${get_env("STACKIT_SERVICE_ACCOUNT_KEY", "${try(local.env.locals.stackit_service_account_key, "")}")}"
        service_account_key_path = "${get_env("STACKIT_SERVICE_ACCOUNT_KEY_PATH", "${try(local.env.locals.stackit_service_account_key_path, "")}")}"
        service_account_token = "${get_env("STACKIT_SERVICE_ACCOUNT_TOKEN", "${try(local.env.locals.stackit_service_account_token, "")}")}"
        private_key = "${get_env("STACKIT_PRIVATE_KEY", "${try(local.env.locals.stackit_private_key, "")}")}"
        private_key_path = "${get_env("STACKIT_PRIVATE_KEY_PATH", "${try(local.env.locals.stackit_private_key_path, "")}")}"
        enable_beta_resources = "${get_env("STACKIT_ENABLE_BETA_RESOURCES", "${try(local.env.locals.stackit_enable_beta_resources, "false")}")}"
     }
  EOF
}
