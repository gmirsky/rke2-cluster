# output "regions" {
#   value       = module.regions.regions
#   description = "Regions"
#   sensitive   = false
# }
#
output "azure_primary_region" {
  value       = var.azure_primary_region
  description = "value of the Azure primary region"
  sensitive   = false
}
#
output "azurerm_resource_group" {
  value       = var.azurerm_resource_group_name
  description = "Name of the resource group"
  sensitive   = false
}
#
# output "azurerm_virtual_network" {
#   value       = azurerm_virtual_network.this.name
#   description = "Name of the virtual network"
#   sensitive   = false
# }
# #
# output "azurerm_subnet" {
#   value       = azurerm_subnet.this.name
#   description = "Name of the subnet"
#   sensitive   = false
# }
#
output "key_data" {
  value       = azapi_resource_action.ssh_public_key_gen.output.publicKey
  description = "SSH public key data"
  sensitive   = false
}
#
# output "nic_name" {
#   value       = azurerm_network_interface.this[*].name
#   description = "value of the network interface name"
#   sensitive   = false
# }
#
# output "nic_ip" {
#   value       = azurerm_network_interface.this[*].ip_configuration[*].private_ip_address
#   description = "value of the network interface ip"
#   sensitive   = false
# }
#
output "azurerm_storage_account_name_server" {
  value       = azurerm_storage_account.server[*].name
  description = "value of the storage account names for the server"
  sensitive   = false
}
#
output "azurerm_storage_account_name_agent" {
  value       = azurerm_storage_account.agent[*].name
  description = "value of the storage account names for the agent"
  sensitive   = false
}
#
output "random_id" {
  value       = random_id.this.*.hex
  description = "value of the random_id"
  sensitive   = false
}
#
# # Bastion outputs
# #
# output "bastion_name" {
#   description = "The name of the bastion resource"
#   value = azurerm_bastion_host.bastion.name
# }
# #
# output "bastion_id" {
#   description = "The ID of the Bastion Host."
#   value = azurerm_bastion_host.bastion.name
# }
# #
# output "dns_name" {
#   description = "The FQDN for the Bastion Host."
#   value = azurerm_bastion_host.bastion.dns_name
# }
# #
# output "pip_id" {
#   description = "The FQDN for the Bastion Host."
#   value = azurerm_public_ip.pip.id
# }
# #
# output "pip_address" {
#   description = "The IP address value that was allocated."
#   value = azurerm_public_ip.pip.ip_address
# }
# #