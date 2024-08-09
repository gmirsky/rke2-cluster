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