resource "azurerm_storage_account" "this" {
    count             = var.azurerm_vm_count
    name              = "vm${count.index+1}diag${random_id.this[count.index].hex}"
    resource_group_name = var.azurerm_resource_group_name
    location          = var.azure_primary_region
    account_tier      = "Standard"
    account_replication_type = "LRS"
}
#