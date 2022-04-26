# baremetal-node

This installs Talos on a bare metal instance, where only SSH access is
available.

Mostly due to terraform limitations, it assumes an ssh agent is running in the
environment, with the necessary key loaded into it.

This is necessary in environments where PXE-booting is not possible, and
there's no cloud-provider, or way to attach userdata either.

It'll dd the bare metal amd64 image to ${var.destination_disk} and reboot.

The config gets put in a `CIDATA` FAT32 partition, which is picked up from the
installer on the first boot. No manual `talosctl apply-config` is necessary.

## Usage
```hcl
module "some_node" {
  source = "path/to/this/module"
  destination_disk = "/dev/nvme0n1"
  talos_node_config = "NODECONFIGHERE"
  talos_version = "v1.0.3"
  worker_address = "x.x.x.x"
}
```
