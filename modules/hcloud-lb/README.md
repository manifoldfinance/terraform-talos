# hcloud-lb

This creates a load balancer in hcloud, which will balance traffic to all
servers with `type=controlplane` label. It will forward port `6443`
(`kube-apiserver` endpoint) and port `50000` (talos api) there.

It exposes the generated load balancer IPv4 and IPv6 adresses as module output.

You probably want to configure a DNS record with these IPs, and add the
hostname to the `machine.certSANs` field in the Talos config.
