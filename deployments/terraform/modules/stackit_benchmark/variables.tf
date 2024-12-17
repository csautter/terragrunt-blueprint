variable "env" {
  type        = string
  description = "The environment to deploy to"
}

variable "project_id" {
  type        = string
  description = "The project ID"
}

variable "yabdb_urls" {
  type        = list(string)
  description = "The URLs of the YABDB instances"
}