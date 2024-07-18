variable "azure_primary_region" {
  type = string
  validation {
    condition = contains(
      module.regions.all_region_names,
      var.azure_primary_region
    )
    error_message = "The primary region must be a supported region."
  }
  description = "Value of the primary region"
  sensitive   = false
  default     = "eastus"
}
#
variable "availability_zones_required" {
  type        = bool
  description = "Whether to include availability zones in the regions."
  sensitive   = false
  default     = false
}
#
variable "include_only_recommended_regions" {
  type        = bool
  description = "Whether to include only recommended regions."
  sensitive   = false
  default     = false
}
#
variable "geography_group" {
  type        = string
  description = "Geography group to filter regions."
  sensitive   = false
  default     = "US"
}
#
variable "azurerm_resource_group_name" {
  type        = string
  description = "Name of the resource group."
  sensitive   = false
  default     = "rg-terraform-azure-test"
}
#
variable "azurerm_virtual_network_name" {
  type        = string
  description = "Name of the virtual network."
  sensitive   = false
  default     = "vnet-terraform-azure-test"
}
#
variable "azurerm_virtual_network_address_space" {
  type        = list(string)
  description = "Address space of the virtual network."
  sensitive   = false
  default     = ["10.0.0.0/16"]
}
#
variable "azurerm_subnet_name" {
  type        = string
  description = "Name of the subnet."
  sensitive   = false
  default     = "subnet-test"
}
#
variable "azurerm_subnet_address_prefixes" {
  type        = list(string)
  description = "Address prefixes of the subnet."
  sensitive   = false
  default = [
    "10.0.0.0/24"
  ]
}
#
variable "azurerm_network_security_group_name" {
  type        = string
  description = "Name of the network security group."
  sensitive   = false
  default     = "nsg-terraform-azure-test"
}
#
variable "azurerm_network_interface_prefix" {
  type        = string
  description = "Prefix of the network interface."
  sensitive   = false
  default     = "nic"
}
#
variable "azurerm_vm_count" {
  type        = number
  description = "Number of network interfaces."
  sensitive   = false
  default     = 2
  validation {
    condition     = var.azurerm_vm_count > 0
    error_message = "The number of network interfaces must be greater than 0."
  }
}
#
variable "vm_admin_username" {
  type        = string
  description = "Username of the virtual machine."
  sensitive   = false
  default     = "azureuser"
}
#
