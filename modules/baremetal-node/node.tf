resource "null_resource" "node" {
  connection {
    type  = "ssh"
    user  = "root"
    host  = var.worker_address
    agent = true
  }

  provisioner "remote-exec" {
    inline = [
      "set -o errexit",
      "wipefs -af ${var.destination_disk}",
      "wget https://github.com/talos-systems/talos/releases/download/${var.talos_version}/nocloud-amd64.raw.xz",
      "xzcat nocloud-amd64.raw.xz | dd of=${var.destination_disk} bs=1M",
      # extend partition table to physical disk size
      "sgdisk --move-second-header ${var.destination_disk}",
      # create new CIDATA partition at the end of the disk
      "sgdisk --new 0:-100M:0 --typecode 0:8300 ${var.destination_disk} --change-name=0:'CIDATA' ${var.destination_disk}",
      "sync",
      "partprobe",
      "sleep 1",

      # format
      "mkfs.vfat -F 32 -n CIDATA /dev/disk/by-partlabel/CIDATA",
      # mount
      "mkdir -p /mnt/cidata",
      "mount /dev/disk/by-partlabel/CIDATA /mnt/cidata",
      # write config as user-data
      "echo ${base64encode(jsonencode(var.talos_node_config))} | base64 -d > /mnt/cidata/user-data",
      # done!
      "umount /mnt/cidata",
      "systemctl --no-block reboot",
    ]
  }
}
