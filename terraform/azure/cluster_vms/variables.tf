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
variable "azurerm_virtual_network_address_space" {
  type        = list(string)
  description = "Address space of the virtual network."
  sensitive   = false
  default     = ["10.0.0.0/16"]
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
variable "vm_admin_username" {
  type        = string
  description = "Username of the virtual machine."
  sensitive   = false
  default     = "azureuser"
}
#
variable "custom_tags" {
  description = "Custom Azure tags provided by the user"
  type        = map(string)
  default = {
  }
  sensitive = false
}
#
variable "environment" {
  description = "Environment value"
  type        = string
  validation {
    condition = can(
      regex(
        "dev|test|qa|prod",
        var.environment
      )
    )
    error_message = "ERROR: environment must be of type: dev, test, qa, prod."
  }
  sensitive = false
}
#
variable "server_ip_addressess" {
  description = "IP addresses of the servers"
  type        = list(string)
  default     = []
  sensitive   = false
}
#
variable "agent_ip_addresses" {
  description = "IP addresses of the agents"
  type        = list(string)
  default     = []
  sensitive   = false
}
#