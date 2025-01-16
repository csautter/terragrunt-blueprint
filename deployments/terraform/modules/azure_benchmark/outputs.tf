output "machine_type_count" {
  value       = length(local.machine_types_store)
  description = "The number of machine types"
}