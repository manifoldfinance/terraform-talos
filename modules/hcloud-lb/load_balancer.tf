# This creates a load-balancer, that will collect over all servers with
# type=controlplane label
resource "hcloud_load_balancer" "controlplane" {
  name               = "controlplane"
  load_balancer_type = "lb11"
  location           = var.hcloud_region
}

# This adds a new controlplane target to the loadbalancer, which balances among
# all servers with the "role-controlplane" label set.
resource "hcloud_load_balancer_target" "controlplane" {
  type             = "label_selector"
  load_balancer_id = hcloud_load_balancer.controlplane.id
  label_selector   = "type=controlplane"
  use_private_ip   = false
}

# This registers a service at port 6443 (kube-apiserver)
resource "hcloud_load_balancer_service" "kube_apiserver" {
  load_balancer_id = hcloud_load_balancer.controlplane.id
  protocol         = "tcp"
  listen_port      = "6443"
  destination_port = "6443"
}

# This registers a service at port 50000 (talos api)
resource "hcloud_load_balancer_service" "talos_api" {
  load_balancer_id = hcloud_load_balancer.controlplane.id
  protocol         = "tcp"
  listen_port      = "50000"
  destination_port = "50000"
}
