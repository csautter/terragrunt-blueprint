locals {
  env               = "aws_dev"
  region            = "eu-central-1"
  aws_account_id    = "123456789"     # can be overwritten by env variable
  aws_profile       = "123456789_dev" # can be overwritten by env variable
  state_backend     = "http_gitlab"
  gitlab_project_id = "61535451" # required for http_gitlab state backend
}