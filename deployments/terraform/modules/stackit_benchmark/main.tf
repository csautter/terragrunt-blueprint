locals {
  ssh_public_key_path  = "~/.ssh/id_ed25519.pub"
  ssh_private_key_path = "~/.ssh/id_ed25519"
}

resource "stackit_key_pair" "keypair" {
  name       = "default-keypair"
  public_key = chomp(file(local.ssh_public_key_path))
}

resource "stackit_server" "bench" {
  project_id        = var.project_id
  availability_zone = "eu01-1"
  boot_volume = {
    size              = 64
    source_type       = "image"
    source_id         = "59838a89-51b1-4892-b57f-b3caf598ee2f"
    performance_class = "storage_premium_perf1"
  }
  name         = "bench-${replace(var.env, "_", "-")}"
  machine_type = "g1.1"
  keypair_name = stackit_key_pair.keypair.name
  user_data    = file("${path.module}/cloud-init.yaml")


}

resource "null_resource" "provision" {
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file(local.ssh_private_key_path)
    host        = stackit_public_ip.public_ip.ip
  }

  provisioner "remote-exec" {
    script = "${path.module}/provision.sh"
  }

  provisioner "local-exec" {
    command = "mkdir -p ${path.module}/bench/ && scp -o StrictHostKeyChecking=no -i ${local.ssh_private_key_path} ubuntu@${stackit_public_ip.public_ip.ip}:/tmp/benchmark.json ${path.module}/bench/${stackit_server.bench.machine_type}.json"
  }

  depends_on = [stackit_server.bench, stackit_server_network_interface_attach.nic_attachment]
}

resource "stackit_network" "network" {
  project_id         = var.project_id
  name               = "bench-network"
  ipv4_nameservers   = ["1.1.1.1", "8.8.8.8"]
  ipv4_prefix_length = 24
}

resource "stackit_network_interface" "nic" {
  project_id         = var.project_id
  network_id         = stackit_network.network.network_id
  security_group_ids = [stackit_security_group.this.security_group_id]
}

resource "stackit_public_ip" "public_ip" {
  project_id           = var.project_id
  network_interface_id = stackit_network_interface.nic.network_interface_id
}

resource "stackit_server_network_interface_attach" "nic_attachment" {
  project_id           = var.project_id
  server_id            = stackit_server.bench.server_id
  network_interface_id = stackit_network_interface.nic.network_interface_id


}

resource "stackit_security_group" "this" {
  project_id = var.project_id
  name       = "example-security-group"
  stateful   = true
}

resource "stackit_security_group_rule" "this" {
  project_id        = var.project_id
  security_group_id = stackit_security_group.this.security_group_id
  direction         = "ingress"
  ether_type        = "IPv4"
}