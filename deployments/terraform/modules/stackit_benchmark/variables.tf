variable "env" {
  type        = string
  description = "The environment to deploy to"
}

variable "project_id" {
  type        = string
  description = "The STACKIT Cloud project ID"
}

variable "machine_type_prefix" {
  type        = string
  description = "The machine type prefix. Only machines with this prefix will be considered for the benchmark"
  default     = "xyz999"
}

variable "machine_flavor" {
  type        = string
  description = "The machine flavor. Only machines with this flavor will be considered for the benchmark. Can also be combined with the machine_type_prefix."
  default     = ""
}

variable "compute_engine_flavor_blacklist" {
  type        = list(string)
  description = "The compute engine flavor blacklist. Flavors in this list will not be considered for the benchmark"
  default     = []
}

variable "ssh_public_key_path" {
  type        = string
  description = "The path to the SSH public key"
  default     = "~/.ssh/id_ed25519.pub"
}

variable "ssh_private_key_path" {
  type        = string
  description = "The path to the SSH private key"
  default     = "~/.ssh/id_ed25519"
}

variable "maximum_cost_per_hour" {
  type        = number
  description = "The maximum cost per unit. Machines with a higher cost per unit will not be considered for the benchmark"
  default     = 0.21
}