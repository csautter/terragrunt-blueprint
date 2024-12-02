resource "stackit_security_group" "example" {
  project_id = var.project_id
  name       = "my_security_group"
  labels = {
    "env" = var.env
  }
}