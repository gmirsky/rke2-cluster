module "regions" {
  source                           = "./regions"
  availability_zones_required      = var.availability_zones_required
  geography_group                  = var.geography_group
  include_only_recommended_regions = var.include_only_recommended_regions
}