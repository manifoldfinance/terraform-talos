# This creates a ssh private key that can be used for root login.
# It is necessary so that hcloud does not send emails for each server creation,
# as well as needed to do initial provisioning (to install the Talos system image).
#
# Once Talos has been installed, it's not used anymore.
resource "tls_private_key" "root" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "random_pet" "ssh_key_name" {
  keepers = {
    # Generate a new pet name each time we use another ssh private key
    ssh_key = "${tls_private_key.root.public_key_openssh}"
  }
}

resource "hcloud_ssh_key" "default" {
  name       = "${var.prefix}${random_pet.ssh_key_name.id}"
  public_key = tls_private_key.root.public_key_openssh
}

