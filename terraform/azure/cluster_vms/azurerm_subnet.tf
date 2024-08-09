resource "azurerm_subnet" "this" {
  name                 = lower("subnet-${var.environment}-${random_id.this.hex}")
  resource_group_name  = data.azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = var.azurerm_subnet_address_prefixes
}
#