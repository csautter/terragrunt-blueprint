/*
output "stackit_categories" {
  value       = data.http.stackit_categories.body
  description = "The categories of the Stackit SKUs"
}
*/

/*
output "stackit_skus" {
  value = data.http.stackit_skus.body
}
*/

/*
output "compute_engine_servers" {
  value       = local.compute_engine_servers
  description = "The compute engine map"
}
*/

/*
output "stackit_sku_map" {
  value       = local.stackit_sku_map
  description = "The Stackit SKU map"
}
*/

/*
output "compute_engine_servers_sku_map" {
  value       = local.compute_engine_servers_sku_map
  description = "The compute engine servers SKU map"
}
*/

/*
output "compute_engine_servers_sku_map_filtered" {
  value       = local.compute_engine_servers_sku_map_filtered
  description = "The compute engine servers SKU map filtered"
}
*/

output "benchmark_machine_count" {
  value       = local.benchmark_machine_count
  description = "The number of machines in the benchmark"
}

output "benchmark_aggregated_cost" {
  value       = local.benchmark_aggregated_cost
  description = "The aggregated cost of the benchmark"
}