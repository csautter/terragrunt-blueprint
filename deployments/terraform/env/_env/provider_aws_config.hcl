locals {
  env_local = try(read_terragrunt_config(find_in_parent_folders("env_local.hcl")), { locals = {} })
  env       = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  config = merge(
    local.env.locals,
    local.env_local.locals
  )
}

generate "aws" {
  path      = "provider_aws.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<-EOF
     provider "aws" {
        default_tags {
          tags = {
            Environment = "${local.config.env}"
          }
        }
        region  = "${local.config.region}"
        profile = "${get_env("AWS_PROFILE", "${local.config.aws_profile}")}"
        allowed_account_ids = ["${get_env("AWS_ACCOUNT_ID", "${local.config.aws_account_id}")}"]
     }
  EOF
}
