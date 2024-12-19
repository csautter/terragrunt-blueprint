data "http" "stackit_skus" {
  url = local.stackit_skus_json_url
}

# the file is not sensitive at all but "sensitive" hides the content in the plan output
resource "local_sensitive_file" "stackit_skus" {
  filename = "stackit_skus.json"
  content  = data.http.stackit_skus.response_body
}

data "http" "stackit_categories" {
  url = local.stackit_categories_json_url
}

# the file is not sensitive at all but "sensitive" hides the content in the plan output
resource "local_sensitive_file" "stackit_categories" {
  filename = "stackit_categories.json"
  content  = data.http.stackit_categories.response_body
}

# prepare a list of compute engine servers for the benchmark
locals {
  stackit_categories              = jsondecode(data.http.stackit_categories.response_body)
  compute_engine_flavor_blacklist = ["g1r.8d"]
  compute_engine_list             = local.stackit_categories["categories"]
  compute_engine_map              = [for category in local.compute_engine_list : category if category["id"] == "STA_Compute"]
  compute_engine_servers = [
    for product in local.compute_engine_map[0]["products"] : product if product["apiIdentifier"] == "servers"
  ]

  stackit_skus    = jsondecode(data.http.stackit_skus.response_body)
  stackit_sku_map = { for service in local.stackit_skus["services"] : service["sku"] => service }


  compute_engine_servers_sku_map = {
    for server in local.compute_engine_servers[0]["skus"] : server["sku"] => lookup(local.stackit_sku_map, server["sku"], null) if lookup(local.stackit_sku_map, server["sku"], null) != null
  }

  compute_engine_servers_sku_map_filtered = {
    for sku, server in local.compute_engine_servers_sku_map : sku => server if(contains(["GPU"], server["attributes"]["hardware"]) == false && contains(local.compute_engine_flavor_blacklist, server["attributes"]["flavor"]) == false && server["attributes"]["metro"] == false && server["price"] < 1.0 && server["attributes"]["ram"] >= 1.5)
  }

  compute_engine_servers_sku_map_filtered_test = {
    for sku, server in local.compute_engine_servers_sku_map_filtered : sku => server if(server["attributes"]["hardware"] == "ARM")
  }

  benchmark_machine_count   = length(local.compute_engine_servers_sku_map_filtered)
  benchmark_aggregated_cost = sum([for sku, server in local.compute_engine_servers_sku_map_filtered : server["price"]])
}