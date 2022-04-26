output "load_balancer_ipv4" {
  value = hcloud_load_balancer.controlplane.ipv4
}

output "load_balancer_ipv6" {
  value = hcloud_load_balancer.controlplane.ipv6
}
