variable "machine_type_iterator" {
  type        = number
  description = "The machine type iterator"
  default     = 0
  validation {
    condition     = var.machine_type_iterator >= 0 && var.machine_type_iterator < length(local.machine_types_all)
    error_message = "The machine type iterator must be greater than 0 and less than the number of machine types"
  }
}

variable "machine_type_name" {
  type        = string
  description = "The machine type name like Standard_B2ms"
  default     = ""
}