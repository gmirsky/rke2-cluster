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
variable "custom_tags" {
  description = "Custom Azure tags provided by the user"
  type        = map(string)
  default = {
  }
  sensitive = false
}
#
variable "account_tier" {
  type        = string
  description = "Defines the Tier to use for this Storage Account. Valid options are Standard and Premium."
  validation {
    condition = can(
      regex(
        "Standard|Premium",
        var.account_tier
      )
    )
    error_message = "ERROR: account_tier must be of type: Standard or Premium."
  }
  sensitive = false
  default   = "Standard"
}
#
variable "account_replication_type" {
  type        = string
  description = "Defines the type of replication to use for this Storage Account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS, RA_GZRS."
  validation {
    condition = can(
      regex(
        "LRS|GRS|RAGRS|ZRS|GZRS|RA_GZRS",
        var.account_replication_type
      )
    )
    error_message = "ERROR: account_replication_type must be of type: LRS, GRS, RAGRS, ZRS, GZRS, RA_GZRS."
  }
  sensitive = false
  default   = "LRS"
}
#
variable "azurerm_storage_account_name" {
  type        = string
  description = "Name of the storage account."
  sensitive   = false
  default     = "tfstatestorageaccount"
}
#
