locals {
  machine_types = length(var.machine_type_name) > 0 ? [var.machine_type_name] : [local.machine_types_all[var.machine_type_iterator]]
  # one machine type group represents a set of machines with similar specs
  # use https://cloudprice.net/ to find similar machine types and extend the list depending on the requirements
  machine_types_groups = {
    "2vcpu_8gb_x64" = [
      "Standard_B2as_v2",
      "Standard_B2ms",
      "Standard_B2s_v2",
      "Standard_D2_v3",
      "Standard_D2_v4",
      "Standard_D2_v5",
      "Standard_D2a_v4",
      "Standard_D2ads_v5",
      "Standard_D2ads_v6",
      "Standard_D2as_v4",
      "Standard_D2as_v5",
      "Standard_D2as_v6",
      "Standard_D2d_v4",
      "Standard_D2d_v5",
      "Standard_D2ds_v4",
      "Standard_D2ds_v5",
      "Standard_D2s_v3",
      "Standard_D2s_v4",
      "Standard_D2s_v5",
      "Standard_DC2ads_v5",
      "Standard_DC2as_v5",
      "Standard_F2as_v6",
    ],
    "2vcpu_8gb_arm64" = [
      "Standard_B2ps_v2",
      "Standard_D2pds_v5",
      "Standard_D2pds_v6",
      "Standard_D2ps_v5",
      "Standard_D2ps_v6"
    ]
  }
  machine_types_all    = flatten(values(local.machine_types_groups))
  ssh_public_key_path  = "~/.ssh/id_ed25519.pub"
  ssh_private_key_path = "~/.ssh/id_ed25519"
}