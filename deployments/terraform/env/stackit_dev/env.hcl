locals {
  env                           = "stackit_dev"
  region                        = "eu01"
  stackit_enable_beta_resources = true

  # create an env_local.hcl file in the same directory as this file
  # to store individual settings which should not be checked in
  # you can also place secrets TEMPORARY! in the env_local.hcl file if required for testing
  # but remember to remove them afterwards - use a secret store instead

  ## the project_id can be found on the dashboard
  # project_id    = ""
  # state_backend = "s3_stackit"
  # state_s3_bucket = "<your>-terraform-states" # change this to your individual bucket name
}