terraform {
  required_version = ">= 1.9.2"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.111.0"
    }
    azapi = {
      source  = "azure/azapi"
      version = ">= 1.14.0"
    }
  }
}
#