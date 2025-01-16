variable "env" {
  type        = string
  description = "The environment to deploy to"
}

variable "project_id" {
  type        = string
  description = "The project ID"
}

variable "machine_type_prefix" {
  type        = string
  description = "The machine type prefix"
}

variable "compute_engine_flavor_blacklist" {
  type        = list(string)
  description = "The compute engine flavor blacklist"
  default     = []
}