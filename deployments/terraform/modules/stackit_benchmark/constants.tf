locals {
  ssh_public_key_path           = "~/.ssh/id_ed25519.pub"
  ssh_private_key_path          = "~/.ssh/id_ed25519"
  availability_zones            = ["eu01-1", "eu01-2", "eu01-3"]
  current_availability_zone     = local.availability_zones[0]
  boot_volume_performance_class = "storage_premium_perf1"
  # https://docs.api.eu01.stackit.cloud/documentation/pim-api/version/v1#tag/ApiService/operation/GetSKUs
  stackit_skus_json_url = "https://pim.api.eu01.stackit.cloud/v1/skus"
  # https://docs.api.eu01.stackit.cloud/documentation/pim-api/version/v1#tag/ApiService/operation/GetCategories
  stackit_categories_json_url = "https://pim.api.eu01.stackit.cloud/v1/categories"
}