resource "hcloud_server" "node" {
  count = var.node_count

  name        = "${var.prefix}${count.index}"
  server_type = var.hcloud_server_type
  image       = "ubuntu-20.04"
  rescue      = "linux64"
  location    = var.hcloud_region
  ssh_keys    = [hcloud_ssh_key.default.id]
  labels      = var.hcloud_server_labels
  user_data   = jsonencode(var.talos_node_config)

  connection {
    type        = "ssh"
    user        = "root"
    private_key = tls_private_key.root.private_key_pem
    host        = self.ipv4_address
  }

  provisioner "remote-exec" {
    inline = [
      "wget https://github.com/talos-systems/talos/releases/download/${var.talos_version}/hcloud-amd64.raw.xz",
      "xzcat hcloud-amd64.raw.xz | dd of=/dev/sda bs=1M",
      "sync",
      "systemctl --no-block reboot",
    ]
  }
}
