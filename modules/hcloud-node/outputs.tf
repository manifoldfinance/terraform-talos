output "nodes_ipv4" {
  value = hcloud_server.node[*].ipv4_address
}

output "nodes_ipv6" {
  value = hcloud_server.node[*].ipv6_address
}
