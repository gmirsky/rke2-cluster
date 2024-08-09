resource "azurerm_linux_virtual_machine" "server" {
  count                      = local.server_count
  admin_username             = var.vm_admin_username
  computer_name              = lower("${var.environment}rke2s${count.index + 1}")
  encryption_at_host_enabled = true
  location                   = data.azurerm_resource_group.this.location
  name                       = lower("${var.environment}rke2s${count.index + 1}")
  reboot_setting             = "IfRequired"
  resource_group_name        = data.azurerm_resource_group.this.name
  network_interface_ids = [
    azurerm_network_interface.server[count.index].id
  ]
  size = "Standard_DS1_v2"
  os_disk {
    name                 = "osdisk-${count.index + 1}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  admin_ssh_key {
    username   = var.vm_admin_username
    public_key = azapi_resource_action.ssh_public_key_gen.output.publicKey
  }
  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.server[count.index].primary_blob_endpoint
  }
}
#
