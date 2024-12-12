locals {
  env                           = "stackit_dev"
  region                        = "eu01"
  stackit_enable_beta_resources = true

  # the project_id can be found on the dashboard
  project_id      = ""
  state_backend   = "s3_stackit"
  state_s3_bucket = "<your>-terraform-states" # change this to your individual bucket name
}