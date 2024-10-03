# output "vm" {
#   value       = var.vm
#   description = "vm object"
#   sensitive   = false
# }
#
output "name_of_ssh_public_key" {
  value = data.local_file.ssh_public_key.content
}
#
output "server_ips" {
  value = local.server_ips
}
