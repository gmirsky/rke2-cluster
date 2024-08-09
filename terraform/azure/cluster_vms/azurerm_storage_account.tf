resource "azurerm_storage_account" "server" {
  count                    = local.server_count
  name                     = lower("${var.environment}server${count.index + 1}${random_id.this.hex}")
  resource_group_name      = data.azurerm_resource_group.this.name
  location                 = data.azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = module.azure_user_tags.tags
}
#
resource "azurerm_storage_account" "agent" {
  count                    = local.agent_count
  name                     = lower("${var.environment}agent${count.index + 1}${random_id.this.hex}")
  resource_group_name      = data.azurerm_resource_group.this.name
  location                 = data.azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = module.azure_user_tags.tags
}
#