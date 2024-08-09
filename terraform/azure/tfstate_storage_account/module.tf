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