resource "azurerm_network_interface" "server" {
  count               = local.server_count
  name                = "nic-${var.environment}-server-${1 + count.index}-${random_id.this.hex}"
  location            = data.azurerm_resource_group.this.location
  resource_group_name = data.azurerm_resource_group.this.name
  ip_configuration {
    name                          = "internal-server-${1 + count.index}"
    subnet_id                     = azurerm_subnet.this.id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.server_ip_addressess[count.index]
  }
}
#
resource "azurerm_network_interface" "agent" {
  count               = local.agent_count
  name                = "nic-${var.environment}-agent-${1 + count.index}-${random_id.this.hex}"
  location            = data.azurerm_resource_group.this.location
  resource_group_name = data.azurerm_resource_group.this.name
  ip_configuration {
    name                          = "internal-agent-${1 + count.index}"
    subnet_id                     = azurerm_subnet.this.id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.agent_ip_addresses[count.index]
  }
}
#