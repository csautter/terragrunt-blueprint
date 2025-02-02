output "machine_type_count" {
  value       = length(local.machine_types_all)
  description = "The number of machine types"
}