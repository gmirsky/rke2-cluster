locals {
  server_count = length(var.server_ip_addressess)
  agent_count  = length(var.agent_ip_addresses)
}
#
