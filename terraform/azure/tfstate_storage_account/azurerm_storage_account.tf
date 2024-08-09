resource "azurerm_storage_account" "this" {
  name                            = var.azurerm_storage_account_name
  resource_group_name             = var.azurerm_resource_group_name
  location                        = var.azure_primary_region
  account_tier                    = var.account_tier
  account_kind                    = "StorageV2"
  account_replication_type        = var.account_replication_type
  tags                            = module.azure_user_tags.tags
  allow_nested_items_to_be_public = false
  min_tls_version                 = "TLS1_2"
  #shared_access_key_enabled       = true
  #public_network_access_enabled   = false
  sas_policy {
    expiration_action = "Log"
    expiration_period = "90.00:00:00"
  }
  blob_properties {
    delete_retention_policy {
      days = 7
    }
  }
  queue_properties {
    logging {
      version               = "1.0"
      read                  = false
      write                 = false
      delete                = false
      retention_policy_days = 10
    }
  }
}
#
