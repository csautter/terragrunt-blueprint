locals {
  env_locals        = read_terragrunt_config(find_in_parent_folders("${get_original_terragrunt_dir()}/../env.hcl"))
  gitlab_url_eval   = can(local.env_locals.locals.gitlab_url) ? local.env_locals.locals.gitlab_url : "https://gitlab.com"
  gitlab_project_id = local.env_locals.locals.gitlab_project_id
}

remote_state {
  backend = "http"
  generate = {
    path      = "backend_http_gitlab.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    address        = "${local.gitlab_url_eval}/api/v4/projects/${local.env_locals.locals.gitlab_project_id}/terraform/state/${local.env_locals.locals.env}_${basename(get_original_terragrunt_dir())}"
    lock_address   = "${local.gitlab_url_eval}/api/v4/projects/${local.env_locals.locals.gitlab_project_id}/terraform/state/${local.env_locals.locals.env}_${basename(get_original_terragrunt_dir())}/lock"
    unlock_address = "${local.gitlab_url_eval}/api/v4/projects/${local.env_locals.locals.gitlab_project_id}/terraform/state/${local.env_locals.locals.env}_${basename(get_original_terragrunt_dir())}/lock"
    lock_method    = "POST"
    unlock_method  = "DELETE"
    retry_wait_min = 5
    username       = "${get_env("TF_HTTP_USERNAME")}"
  }
}