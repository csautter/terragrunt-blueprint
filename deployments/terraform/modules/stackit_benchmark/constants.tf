locals {
  machine_types        = ["g1.1", "g1.2", "g1.3", "g1.4", "g1.5"]
  ssh_public_key_path  = "~/.ssh/id_ed25519.pub"
  ssh_private_key_path = "~/.ssh/id_ed25519"
  availability_zones   = ["eu01-1", "eu01-2", "eu01-3"]
}