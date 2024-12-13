locals {
  env_local = try(read_terragrunt_config(find_in_parent_folders("env_local.hcl")), { locals = {} })
  env       = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  config = merge(
    local.env.locals,
    local.env_local.locals
  )
}

remote_state {
  backend      = "s3"
  disable_init = true

  generate = {
    path      = "backend_s3_stackit.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    bucket                             = local.config.state_s3_bucket
    key                                = "${local.config.env}_${basename(get_original_terragrunt_dir())}.tfstate"
    endpoint                           = "https://object.storage.${local.config.region}.onstackit.cloud"
    region                             = local.config.region
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