locals {
  machine_types_ready = [
    "Standard_F2"
  ]
  machine_types = [local.machine_types_store[0]]
  machine_types_store = [
    # "Standard_F2",
    #"B2pts v2", #arm
    #"B2pls v2", #arm
    #"B4pls v2", #arm
    "Standard_B2ls_v2",
    "B2s_v2",
    "B4ls_v2",
    "B2als_v2",
    "B2as_v2",
    "B4als_v2",
    "B1ms",
    "B2s",
    "B4ms",
    "A1 v2",
    "A2 v2",
    "A4 v2",
    "D2as v6",
    "D4as v6",
    "D2ads v6",
    "D2als v6",
    "D4als v6",
    "D2as v5",
    "D4as v5",
    # D2ps v5 # arm
    # D4ps v5 # arm
    # D2pds v5 # arm
    # D4pds v5 # arm
    # D2pls v5 # arm
    # D4pls v5 # arm
    # D2plds v5 # arm
    # D4plds v5	# arm
    # D2ps v6 # arm
    # D4ps v6 # arm
    # D2pds v6 # arm
    # D4pds v6 # arm
    # D2pls v6 # arm
    # D4pls v6 # arm
    # D2plds v6 # arm
    # D4plds v6 # arm
    "D2s_v6",
    "D4s_v6",
    "D2ds_v6",
    "D4ds_v6",
    "D2ls_v6",
    "D4ls_v6",
    "D2_v5",
    "D4_v5",
    "D2s_v5",
    "D4s_v5",
    "D2ls_v5",
    "D4ls_v5",
    "DC2as v5",
    "DC4as v5",
    "D2 v4",
    "D4 v4",
    "D2s v4",
    "D4s v4",
    "DC1s v3",
    "DC2s v3",
    "DC4s v3",
    "DS1 v2",
    "DS2 v2",
  ]
  ssh_public_key_path  = "~/.ssh/id_ed25519.pub"
  ssh_private_key_path = "~/.ssh/id_ed25519"
}