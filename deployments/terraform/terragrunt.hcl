locals {
  env_locals                = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  tflint_hook_enabled       = get_env("DISABLE_TFLINT_HOOK", "false") == "true" ? false : true
  trivy_hook_enabled        = get_env("DISABLE_TRIVY_HOOK", "false") == "true" ? false : true
  backend_target_evaluation = can(local.env_locals.locals.state_backend) ? local.env_locals.locals.state_backend : "local"
  backend_target            = contains(["http_gitlab", "local", "s3_stackit"], local.backend_target_evaluation) ? local.backend_target_evaluation : "local"
  backend_config            = read_terragrunt_config(find_in_parent_folders("backend_${local.backend_target}.hcl"))
}

remote_state {
  backend  = local.backend_config.remote_state.backend
  config   = local.backend_config.remote_state.config
  generate = local.backend_config.remote_state.generate
}

terraform {
  before_hook "terraform_fmt" {
    commands = ["apply", "plan"]
    execute  = ["terraform", "fmt", "-recursive"]
  }
  before_hook "terragrunt_hclfmt" {
    commands = ["apply", "plan"]
    execute  = ["terragrunt", "hclfmt"]
  }
  before_hook "tflint" {
    commands = local.tflint_hook_enabled ? ["apply", "plan"] : []
    execute  = ["tflint"]
  }
  before_hook "trivy" {
    commands = local.trivy_hook_enabled ? ["apply", "plan"] : []
    execute  = ["trivy", "config", "."]
  }
}
