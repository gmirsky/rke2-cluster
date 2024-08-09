resource "azapi_resource" "ssh_public_key" {
  type      = "Microsoft.Compute/sshPublicKeys@2022-11-01"
  name      = "ssh-public-key-${var.environment}-${random_id.this.hex}"
  location  = data.azurerm_resource_group.this.location
  parent_id = data.azurerm_resource_group.this.id
}
#