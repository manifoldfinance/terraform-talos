# hcloud-node

This creates servers in [Hetzner Cloud](https://www.hetzner.com/cloud).
It can be used to both create workers or controlplane nodes.

Among others, it has configuration knobs for the number of nodes, their machine
type, region, name prefix.

If controlplane nodes are created, the labels knob can be used in concert with
the `hcloud-lb` module to mark servers accordingly for load balancer backend
selection.

The Talos machine config is passed as userdata to the machines.
Care needs to be taken when updating existing nodes with a new machine
config/userdata, as it'll cause machine recreation. So make sure to properly
drain the machines individually before applying these changes.

##Usage
```hcl
  source = "path/to/this/module"

  hcloud_region = "fsn1"
  hcloud_server_labels = {
    type = "controlplane"
  }
  hcloud_server_type = "cpx31"
  node_count         = 3
  prefix             = "talos-controlplane-"
  talos_node_config  = "NODECONFIGHERE"
  talos_version      = "v1.0.3"
}
```
