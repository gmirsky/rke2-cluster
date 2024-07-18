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
  value       = azurerm_resource_group.this.name
  description = "Name of the resource group"
  sensitive   = false
}
#
output "azurerm_virtual_network" {
  value       = azurerm_virtual_network.this.name
  description = "Name of the virtual network"
  sensitive   = false
}
#
output "azurerm_subnet" {
  value       = azurerm_subnet.this.name
  description = "Name of the subnet"
  sensitive   = false
}
#
output "key_data" {
  value       = azapi_resource_action.ssh_public_key_gen.output.publicKey
  description = "SSH public key data"
  sensitive   = false
}
#
output "nic_name" {
  value = azurerm_network_interface.this[*].name
  description = "value of the network interface name"
  sensitive = false
}
#
output "nic_ip" {
  value = azurerm_network_interface.this[*].ip_configuration[*].private_ip_address
  description = "value of the network interface ip"
  sensitive = false
}
#
output "azurerm_storage_account_name" {
    value = azurerm_storage_account.this.*.name
    description = "value of the azurerm_storage_account_name"
    sensitive = false
}
#
output "random_id" {
  value = random_id.this.*.hex
  description = "value of the random_id"
  sensitive = false
}
#
output "azurerm_linux_virtual_machine" {
  value = azurerm_linux_virtual_machine.this[*].name
  description = "value of the azurerm_linux_virtual_machine"
  sensitive = false
}
#