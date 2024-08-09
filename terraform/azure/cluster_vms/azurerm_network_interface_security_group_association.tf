resource "azurerm_network_interface_security_group_association" "server" {
  count                     = local.server_count
  network_interface_id      = azurerm_network_interface.server[count.index].id
  network_security_group_id = azurerm_network_security_group.this.id
}
#
resource "azurerm_network_interface_security_group_association" "agent" {
  count                     = local.agent_count
  network_interface_id      = azurerm_network_interface.agent[count.index].id
  network_security_group_id = azurerm_network_security_group.this.id
}
#