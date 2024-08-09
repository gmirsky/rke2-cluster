module "regions" {
  source                           = "../regions"
  availability_zones_required      = var.availability_zones_required
  geography_group                  = var.geography_group
  include_only_recommended_regions = var.include_only_recommended_regions
}
#
module "azure_user_tags" {
  custom_tags = var.custom_tags
  environment = var.environment
  source      = "../user_tags"
}
#
# module "bastion_host" {
#   source                = "george-markou/bastion-host/azurerm"
#   version               = "1.0.0"
#   resource_group_name   = data.azurerm_resource_group.this.name
#   location              = data.azurerm_resource_group.this.location
#   pip_name              = "my-bas-pip-01"
#   bastion_name          = "my-bas-01"
#   subnet_id             = azurerm_subnet.this.id
#   copy_paste_enabled    = true
#   file_copy_enabled     = false
#   ip_connect_enabled    = true
#   shareable_link_enabled = true
#   tunneling_enabled     = false
#   sku                   = "Standard"
#   tags = module.azure_user_tags.tags
# }
