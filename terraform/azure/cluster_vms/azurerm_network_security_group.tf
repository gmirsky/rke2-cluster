resource "azurerm_network_security_group" "this" {
  name                = "nsg-${var.environment}-${random_id.this.hex}"
  location            = data.azurerm_resource_group.this.location
  resource_group_name = data.azurerm_resource_group.this.name
}
#