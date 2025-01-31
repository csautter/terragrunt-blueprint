locals {
  machine_types = [local.machine_types_store[var.machine_type_iterator]]
  machine_types_store = [
    "Standard_F2", # 2 vCPUs, 4 GB RAM
    #"B2pts v2",            # 2 vCPUs, 8 GB RAM (ARM)
    #"B2pls v2",            # 2 vCPUs, 16 GB RAM (ARM)
    #"B4pls v2",            # 4 vCPUs, 32 GB RAM (ARM)
    "Standard_B2ls_v2",  # 2 vCPUs, 4 GB RAM
    "Standard_B2s_v2",   # 2 vCPUs, 8 GB RAM
    "Standard_B4ls_v2",  # 4 vCPUs, 8 GB RAM
    "Standard_B2als_v2", # 2 vCPUs, 4 GB RAM
    "Standard_B2as_v2",  # 2 vCPUs, 8 GB RAM
    "Standard_B4als_v2", # 4 vCPUs, 8 GB RAM
    "Standard_B1ms",     # 1 vCPU, 2 GB RAM
    "Standard_B2s",      # 2 vCPUs, 4 GB RAM
    "Standard_B4ms",     # 4 vCPUs, 16 GB RAM
    "Standard_A1_v2",    # 1 vCPU, 2 GB RAM
    "Standard_A2_v2",    # 2 vCPUs, 4 GB RAM
    #"Standard_A4_v2",    # 4 vCPUs, 8 GB RAM ---- ERROR
    #"Standard_D2as_v6",  # 2 vCPUs, 8 GB RAM ---- ERROR
    #"Standard_D4as_v6",  # 4 vCPUs, 16 GB RAM ---- ERROR
    #"Standard_D2ads_v6", # 2 vCPUs, GB RAM ---- ERROR
    #"Standard_D2als_v6", # 2 vCPUs, GB RAM ---- ERROR
    #"Standard_D4als_v6", # 4 vCPUs, GB RAM ---- ERROR
    "Standard_D2as_v5", # 2 vCPUs, GB RAM
    "Standard_D4as_v5", # 4 vCPUs, GB RAM
    # D2ps_v5,              # 2 vCPUs, GB RAM (ARM)
    # D4ps_v5,              # 4 vCPUs, GB RAM (ARM)
    # D2pds_v5,             # 2 vCPUs, GB RAM (ARM)
    # D4pds_v5,             # 4 vCPUs, GB RAM (ARM)
    # D2pls_v5,             # 2 vCPUs, GB RAM (ARM)
    # D4pls_v5,             # 4 vCPUs, GB RAM (ARM)
    # D2plds_v5,            # 2 vCPUs, GB RAM (ARM)
    # D4plds_v5,            # 4 vCPUs, GB RAM (ARM)
    # D2ps_v6,              # 2 vCPUs, GB RAM (ARM)
    # D4ps_v6,              # 4 vCPUs, GB RAM (ARM)
    # D2pds_v6,             # 2 vCPUs, GB RAM (ARM)
    # D4pds_v6,             # 4 vCPUs, GB RAM (ARM)
    # D2pls_v6,             # 2 vCPUs, GB RAM (ARM)
    # D4pls_v6,             # 4 vCPUs, GB RAM (ARM)
    # D2plds_v6,            # 2 vCPUs, GB RAM (ARM)
    # D4plds_v6,            # 4 vCPUs, GB RAM (ARM)
    #"Standard_D2s_v6",  # 2 vCPUs, GB RAM ---- ERROR
    #"Standard_D4s_v6",  # 4 vCPUs, GB RAM ---- ERROR
    #"Standard_D2ds_v6", # 2 vCPUs, GB RAM ---- ERROR
    #"Standard_D4ds_v6", # 4 vCPUs, GB RAM ---- ERROR
    #"Standard_D2ls_v6", # 2 vCPUs, GB RAM ---- ERROR
    #"Standard_D4ls_v6", # 4 vCPUs, GB RAM ---- ERROR
    "Standard_D2_v5",   # 2 vCPUs, GB RAM
    "Standard_D4_v5",   # 4 vCPUs, GB RAM
    "Standard_D2s_v5",  # 2 vCPUs, GB RAM
    "Standard_D4s_v5",  # 4 vCPUs, GB RAM
    "Standard_D2ls_v5", # 2 vCPUs, GB RAM
    "Standard_D4ls_v5", # 4 vCPUs, GB RAM
    #"Standard_DC2as_v5", # 2 vCPUs, GB RAM ---- ERROR
    "Standard_DC4as_v5", # 4 vCPUs, GB RAM
    "Standard_D2_v4",    # 2 vCPUs, GB RAM
    "Standard_D4_v4",    # 4 vCPUs, GB RAM
    "Standard_D2s_v4",   # 2 vCPUs, GB RAM
    "Standard_D4s_v4",   # 4 vCPUs, GB RAM
    #"Standard_DC1s_v3",  # 1 vCPU, GB RAM ---- ERROR - Hypervisor Generation 1
    #"Standard_DC2s_v3",  # 2 vCPUs, GB RAM ---- ERROR - Hypervisor Generation 1
    #"Standard_DC4s_v3",  # 4 vCPUs, GB RAM ---- ERROR - Hypervisor Generation 1
    "Standard_DS1_v2", # 1 vCPU, GB RAM
    "Standard_DS2_v2", # 2 vCPUs, GB RAM
  ]
  ssh_public_key_path  = "~/.ssh/id_ed25519.pub"
  ssh_private_key_path = "~/.ssh/id_ed25519"
}