variable "project_id" {
  type        = string
  description = "The project ID"
}

variable "observability_instance_id" {
  type        = string
  description = "The instance ID of the observability instance"
  default     = ""
}

variable "cluster_name" {
  type        = string
  description = "The name of the cluster"
}

variable "node_pools" {
  type = list(object({
    name                    = string
    machine_type            = string
    os_name                 = string
    os_version_min          = optional(string)
    minimum                 = string
    maximum                 = string
    availability_zones      = list(string)
    cri                     = string
    volume_size             = number
    volume_type             = string
    allow_system_components = bool
  }))
  default = [
    {
      name         = "ske-az3"
      machine_type = "g1.2"
      os_name      = "flatcar"
      # os_version_min          = "3975.2.1"
      minimum                 = "1"
      maximum                 = "3"
      availability_zones      = ["eu01-3"]
      cri                     = "containerd"
      volume_size             = 50
      volume_type             = "storage_premium_perf0"
      allow_system_components = true
    },
    {
      name         = "ske-az2"
      machine_type = "g1.2"
      os_name      = "flatcar"
      # os_version_min          = "3975.2.1"
      minimum                 = "1"
      maximum                 = "3"
      availability_zones      = ["eu01-2"]
      cri                     = "containerd"
      volume_size             = 50
      volume_type             = "storage_premium_perf0"
      allow_system_components = true
    },
    {
      name         = "ske-az1"
      machine_type = "g1.2"
      os_name      = "flatcar"
      # os_version_min          = "3975.2.1"
      minimum                 = "0"
      maximum                 = "3"
      availability_zones      = ["eu01-1"]
      cri                     = "containerd"
      volume_size             = 50
      volume_type             = "storage_premium_perf0"
      allow_system_components = false
    }
  ]
  description = "The node pools to create"
}