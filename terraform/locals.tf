locals {
  server_count = length(var.vm)
  server_ips   = [for r in var.vm : replace(r.ipv4_address, "/24", "")]
}
#