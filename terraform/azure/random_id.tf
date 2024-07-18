resource "random_id" "this" {
  count = var.azurerm_vm_count
  keepers = {
    # Generate a new ID only when a new resource group is defined
    resource_group = var.azurerm_resource_group_name
  }
  byte_length = 8
}
#