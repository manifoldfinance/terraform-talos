variable "destination_disk" {
  type        = string
  description = "Device to copy the Talos installer to"
}

variable "talos_version" {
  type        = string
  description = "The version of Talos Linux to install on creation. Doesn't affect existing nodes."
}

variable "worker_address" {
  type        = string
  description = "IP address or hostname to deploy Talos onto"
}

variable "talos_node_config" {
  description = "The config that should be applied to the node. Keep in mind this only works on a fresh node."
}
