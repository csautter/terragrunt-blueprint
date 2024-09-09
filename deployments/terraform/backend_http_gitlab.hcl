locals {
  env_locals      = read_terragrunt_config(find_in_parent_folders("${get_original_terragrunt_dir()}/../env.hcl"))
  gitlab_url_eval = can(local.env_locals.locals.gitlab_url) ? local.env_locals.locals.gitlab_url : "https://gitlab.com"
}

remote_state {
  backend = "http"
  generate = {
    path      = "backend_http_gitlab.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    address        = "${local.gitlab_url_eval}/api/v4/projects/${local.env_locals.locals.gitlab_project_id}/terraform/state/${local.env_locals.locals.env}_${basename(path_relative_to_include())}"
    lock_address   = "${local.gitlab_url_eval}/api/v4/projects/${local.env_locals.locals.gitlab_project_id}/terraform/state/${local.env_locals.locals.env}_${basename(path_relative_to_include())}/lock"
    unlock_address = "${local.gitlab_url_eval}/api/v4/projects/${local.env_locals.locals.gitlab_project_id}/terraform/state/${local.env_locals.locals.env}_${basename(path_relative_to_include())}/lock"
    lock_method    = "POST"
    unlock_method  = "DELETE"
    retry_wait_min = 5
    username       = "${get_env("TF_HTTP_USERNAME")}"
  }
}