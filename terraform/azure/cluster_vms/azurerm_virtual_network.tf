resource "azurerm_virtual_network" "this" {
  name                = lower("vnet-${var.environment}-${random_id.this.hex}")
  resource_group_name = data.azurerm_resource_group.this.name
  location            = data.azurerm_resource_group.this.location
  address_space       = var.azurerm_virtual_network_address_space
}
#