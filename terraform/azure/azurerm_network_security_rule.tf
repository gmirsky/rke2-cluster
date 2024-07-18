/*
Inbound rules

The RKE2 server needs port 6443 and 9345 to be accessible by other nodes in the cluster.

All nodes need to be able to reach other nodes over UDP port 8472 when Flannel VXLAN is used.

If you wish to utilize the metrics server, you will need to open port 10250 on each node.

Protocol	Port	Source	Destination	Description
TCP	9345	RKE2 agent nodes	RKE2 server nodes	RKE2 supervisor API
TCP	6443	RKE2 agent nodes	RKE2 server nodes	Kubernetes API
UDP	8472	All RKE2 nodes	All RKE2 nodes	Required only for Flannel VXLAN
TCP	10250	All RKE2 nodes	All RKE2 nodes	kubelet metrics
TCP	2379	RKE2 server nodes	RKE2 server nodes	etcd client port
TCP	2380	RKE2 server nodes	RKE2 server nodes	etcd peer port
TCP	2381	RKE2 server nodes	RKE2 server nodes	etcd metrics port
TCP	30000-32767	All RKE2 nodes	All RKE2 nodes	NodePort port range
UDP	8472	All RKE2 nodes	All RKE2 nodes	Cilium CNI VXLAN
TCP	4240	All RKE2 nodes	All RKE2 nodes	Cilium CNI health checks
ICMP	8/0	All RKE2 nodes	All RKE2 nodes	Cilium CNI health checks
TCP	179	All RKE2 nodes	All RKE2 nodes	Calico CNI with BGP
UDP	4789	All RKE2 nodes	All RKE2 nodes	Calico CNI with VXLAN
TCP	5473	All RKE2 nodes	All RKE2 nodes	Calico CNI with Typha
TCP	9098	All RKE2 nodes	All RKE2 nodes	Calico Typha health checks
TCP	9099	All RKE2 nodes	All RKE2 nodes	Calico health checks
UDP	8472	All RKE2 nodes	All RKE2 nodes	Canal CNI with VXLAN
TCP	9099	All RKE2 nodes	All RKE2 nodes	Canal CNI health checks
UDP	51820	All RKE2 nodes	All RKE2 nodes	Canal CNI with WireGuard IPv4
UDP	51821	All RKE2 nodes	All RKE2 nodes	Canal CNI with WireGuard IPv6/dual-stack
UDP	4789	All RKE2 nodes	All RKE2 nodes	Flannel CNI with VXLAN
*/
resource "azurerm_network_security_rule" "metrics_server_10250" {
    name                        = "metrics_server_10250"
    priority                    = 1000
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "10250"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
    resource_group_name         = var.azurerm_resource_group_name
    network_security_group_name = azurerm_network_security_group.this.name
}
#
resource "azurerm_network_security_rule" "flannel_vxlan_8472" {
    name                        = "flannel_vxlan_8472"
    priority                    = 1001
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Udp"
    source_port_range           = "*"
    destination_port_range      = "8472"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
    resource_group_name         = var.azurerm_resource_group_name
    network_security_group_name = azurerm_network_security_group.this.name
  
}
#
resource "azurerm_network_security_rule" "rke2_server_6443" {
    name                        = "rke2_server_6443"
    priority                    = 1002
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "6443"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
    resource_group_name         = var.azurerm_resource_group_name
    network_security_group_name = azurerm_network_security_group.this.name
}
#
resource "azurerm_network_security_rule" "rke2_server_9345" {
    name                        = "rke2_server_9345"
    priority                    = 1003
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "9345"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
    resource_group_name         = var.azurerm_resource_group_name
    network_security_group_name = azurerm_network_security_group.this.name
}   
#
resource "azurerm_network_security_rule" "etcd_client_2379" {
    name                        = "etcd_client_2379"
    priority                    = 1004
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "2379"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
    resource_group_name         = var.azurerm_resource_group_name
    network_security_group_name = azurerm_network_security_group.this.name
}
#
resource "azurerm_network_security_rule" "etcd_peer_2380" {
    name                        = "etcd_peer_2380"
    priority                    = 1005
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "2380"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
    resource_group_name         = var.azurerm_resource_group_name
    network_security_group_name = azurerm_network_security_group.this.name
}
#
resource "azurerm_network_security_rule" "etcd_metrics_2381" {
    name                        = "etcd_metrics_2381"
    priority                    = 1006
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "2381"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
    resource_group_name         = var.azurerm_resource_group_name
    network_security_group_name = azurerm_network_security_group.this.name
}
#
resource "azurerm_network_security_rule" "nodeport_30000_32767" {
    name                        = "nodeport_30000_32767"
    priority                    = 1007
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "30000-32767"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
    resource_group_name         = var.azurerm_resource_group_name
    network_security_group_name = azurerm_network_security_group.this.name
}
#
resource "azurerm_network_security_rule" "cilium_vxlan_8472" {
    name                        = "cilium_vxlan_8472"
    priority                    = 1008
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Udp"
    source_port_range           = "*"
    destination_port_range      = "8472"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
    resource_group_name         = var.azurerm_resource_group_name
    network_security_group_name = azurerm_network_security_group.this.name
}
#
resource "azurerm_network_security_rule" "cilium_health_4240" {
    name                        = "cilium_health_4240"
    priority                    = 1009
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "4240"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
    resource_group_name         = var.azurerm_resource_group_name
    network_security_group_name = azurerm_network_security_group.this.name
}
#
resource "azurerm_network_security_rule" "cilium_health_icmp" {
    name                        = "cilium_health_icmp"
    priority                    = 1010
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Icmp"
    source_port_range           = "*"
    destination_port_range      = "*"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
    resource_group_name         = var.azurerm_resource_group_name
    network_security_group_name = azurerm_network_security_group.this.name
}
#
resource "azurerm_network_security_rule" "calico_bgp_179" {
    name                        = "calico_bgp_179"
    priority                    = 1011
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "179"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
    resource_group_name         = var.azurerm_resource_group_name
    network_security_group_name = azurerm_network_security_group.this.name
}
#
resource "azurerm_network_security_rule" "calico_vxlan_4789" {
    name                        = "calico_vxlan_4789"
    priority                    = 1012
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Udp"
    source_port_range           = "*"
    destination_port_range      = "4789"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
    resource_group_name         = var.azurerm_resource_group_name
    network_security_group_name = azurerm_network_security_group.this.name
}
#
resource "azurerm_network_security_rule" "calico_typha_5473" {
    name                        = "calico_typha_5473"
    priority                    = 1013
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "5473"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
    resource_group_name         = var.azurerm_resource_group_name
    network_security_group_name = azurerm_network_security_group.this.name
}
#
resource "azurerm_network_security_rule" "calico_typha_health_9098" {
    name                        = "calico_typha_health_9098"
    priority                    = 1014
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "9098"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
    resource_group_name         = var.azurerm_resource_group_name
    network_security_group_name = azurerm_network_security_group.this.name
}
#
resource "azurerm_network_security_rule" "calico_health_9099" {
    name                        = "calico_health_9099"
    priority                    = 1015
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "9099"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
    resource_group_name         = var.azurerm_resource_group_name
    network_security_group_name = azurerm_network_security_group.this.name
}
#
resource "azurerm_network_security_rule" "canal_vxlan_8472" {
    name                        = "canal_vxlan_8472"
    priority                    = 1016
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Udp"
    source_port_range           = "*"
    destination_port_range      = "8472"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
    resource_group_name         = var.azurerm_resource_group_name
    network_security_group_name = azurerm_network_security_group.this.name
}
#
resource "azurerm_network_security_rule" "canal_health_9099" {
    name                        = "canal_health_9099"
    priority                    = 1017
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "9099"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
    resource_group_name         = var.azurerm_resource_group_name
    network_security_group_name = azurerm_network_security_group.this.name
}
#
resource "azurerm_network_security_rule" "canal_wireguard_ipv4_51820" {
    name                        = "canal_wireguard_ipv4_51820"
    priority                    = 1018
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Udp"
    source_port_range           = "*"
    destination_port_range      = "51820"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
    resource_group_name         = var.azurerm_resource_group_name
    network_security_group_name = azurerm_network_security_group.this.name
}
#
resource "azurerm_network_security_rule" "canal_wireguard_ipv6_51821" {
    name                        = "canal_wireguard_ipv6_51821"
    priority                    = 1019
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Udp"
    source_port_range           = "*"
    destination_port_range      = "51821"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
    resource_group_name         = var.azurerm_resource_group_name
    network_security_group_name = azurerm_network_security_group.this.name
}
#
resource "azurerm_network_security_rule" "flannel_vxlan_4789" {
    name                        = "flannel_vxlan_4789"
    priority                    = 1020
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Udp"
    source_port_range           = "*"
    destination_port_range      = "4789"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
    resource_group_name         = var.azurerm_resource_group_name
    network_security_group_name = azurerm_network_security_group.this.name
}
#