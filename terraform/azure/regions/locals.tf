locals {
  supported_geos = distinct(
    [for v in local.all_physical_locations_list : v.geography]
  )
  supported_geo_groups = distinct(
    [for v in local.all_physical_locations_list : v.geography_group]
  )
  geo_groups = distinct(
    [for v in local.regions_data_merged : v.geography_group]
  )
  geos = distinct(
    [for v in local.regions_data_merged : v.geography]
  )
  locations           = local.all_locations_list
  region_to_zones_map = { for v in local.all_zonemappings_list : v.location => v.zones }
  unfiltered_regions_data_merged = [
    for location in local.locations :
    merge(
      location,
      {
        zones = lookup(
          local.region_to_zones_map,
          location.display_name,
          []
        )
      }
    )
  ]
  regions_data_merged = [
    for location in local.unfiltered_regions_data_merged : location
    if(!var.availability_zones_required || length(location.zones) > 1)
  ]
  regions_by_display_name = {
    for v in local.regions_data_merged : v.display_name => v
  }
  regions_by_geography_group = {
    for geo_group in local.geo_groups : geo_group => [
      for v in local.regions_data_merged : v if v.geography_group == geo_group
    ]
  }
  regions_by_geography = {
    for geo in local.geos : geo => [
      for v in local.regions_data_merged : v if v.geography == geo
    ]
  }
  regions_by_name = {
    for v in local.regions_data_merged : v.name => v
  }
  all_zonemappings_list = tolist(
    flatten(
      [
        for resource_type in jsondecode(data.azapi_resource_action.compute_provider.output).resourceTypes : [
          for mapping in resource_type.zoneMappings : [
            {
              location = mapping.location
              zones = sort(
                [for zone in mapping.zones : tonumber(zone)]
              )
            }
          ]
        ] if(resource_type.resourceType == "virtualMachines")
      ]
    )
  )
  all_physical_locations_list = [
    for location in jsondecode(data.azapi_resource_action.locations.output).value : {
      display_name       = location.displayName
      geography          = location.metadata.geography
      geography_group    = location.metadata.geographyGroup
      id                 = location.id
      name               = location.name
      paired_region_name = try(one(location.metadata.pairedRegion).name, null)
      recommended        = location.metadata.regionCategory == "Recommended"
    }
    if location.metadata.regionType == "Physical"
  ]
  all_locations_list = [
    for location in local.all_physical_locations_list : location
    if(
      (!var.include_only_recommended_regions || location.recommended) &&
      (var.geography_group == null || location.geography_group == var.geography_group) &&
      (var.geography == null || location.geography == var.geography)
    )
  ]
}
#