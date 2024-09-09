locals {
  env = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

generate "aws" {
  path      = "provider_aws.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<-EOF
     provider "aws" {
        default_tags {
          tags = {
            Environment = "${local.env.locals.env}"
          }
        }
        region  = "${local.env.locals.region}"
        profile = "${get_env("AWS_PROFILE", "${local.env.locals.aws_profile}")}"
        allowed_account_ids = ["${get_env("AWS_ACCOUNT_ID", "${local.env.locals.aws_account_id}")}"]
     }
  EOF
}
