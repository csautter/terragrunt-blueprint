locals {
  env_locals = read_terragrunt_config(find_in_parent_folders("${get_original_terragrunt_dir()}/../env.hcl"))
}

remote_state {
  backend      = "s3"
  disable_init = true

  generate = {
    path      = "backend_s3_stackit.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    bucket                             = local.env_locals.locals.state_s3_bucket
    key                                = "${local.env_locals.locals.env}_${basename(get_original_terragrunt_dir())}.tfstate"
    endpoint                           = "https://object.storage.${local.env_locals.locals.region}.onstackit.cloud"
    region                             = local.env_locals.locals.region
    skip_credentials_validation        = true
    skip_region_validation             = true
    skip_s3_checksum                   = true
    skip_requesting_account_id         = true
    skip_bucket_ssencryption           = true
    skip_bucket_public_access_blocking = true
    force_path_style                   = true
    skip_bucket_root_access            = true
    skip_bucket_enforced_tls           = true
  }
}