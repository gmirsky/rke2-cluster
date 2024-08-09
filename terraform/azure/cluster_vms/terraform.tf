terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.111.0"
    }
    azapi = {
      source  = "azure/azapi"
      version = ">= 1.14.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-demonstration"
    storage_account_name = "tfstate0a2b3c4d5e6fgnm"
    container_name       = "tfstate"
    key                  = "cluster_vms.dev.terraform.tfstate"
  }
}
#