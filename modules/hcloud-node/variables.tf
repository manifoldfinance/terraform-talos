variable "hcloud_region" {
  type        = string
  description = "The hcloud region to create servers resources in"
}

variable "hcloud_server_type" {
  type        = string
  description = "The hcloud server type to provision"
}

variable "hcloud_server_labels" {
  type        = map(string)
  description = "Labels to attach to each node. Useful if you want to mark controlplane nodes for loadbalancers"
  default     = {}
}

variable "node_count" {
  type        = number
  description = "The number of nodes to deploy"
}

variable "prefix" {
  type        = string
  description = "A prefix to use for all server resources"
  default     = "talos-"
}

variable "talos_version" {
  type        = string
  description = "The version of Talos Linux to install on creation. Doesn't affect existing nodes."
}

variable "talos_node_config" {
  description = "The config of Talos to boot each node with. Keep in mind changing this might cause a recreation of a node."
}
