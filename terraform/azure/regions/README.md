# Azure Regions and Availability Zones module

This module provides an output of all Azure regions and availability zones.

The module outputs a list of objects with the following attributes:

- `name` - The name of the region. E.g. "eastus"
- `display_name` - The display name of the region. E.g. "East US".
- `paired_region_name` - The name of the region paired with this region.  May be `null` if the region has no pair.
- `geography` - The geography of the region.
- `geography_group` - The geography group of the region.
- `zones` - A list of the availability zones in the region. Will be `null` if the region does not support zones.

This data is the further composed into useful maps keyed by region name and region display name.

## Usage

```json
module "regions" {
  source  = "Azure/regions/azurerm"
}

output "regions" {
  value = module.regions.regions
}
```

## Credits

Based off the work of matt-FFFFFF and his version found [here](https://github.com/Azure/terraform-azurerm-regions)