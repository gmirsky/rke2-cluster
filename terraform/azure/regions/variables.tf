variable "geography" {
  type        = string
  default     = null
  description = <<DESCRIPTION
  The code for the geography to filter by. For example, "United Kingdom" or "United States".
  DESCRIPTION
  validation {
    condition     = var.geography == null ? true : contains(local.supported_geos, var.geography)
    error_message = "The geography must be a supported value (e.g., ${join(", ", local.supported_geos)})."
  }
  sensitive = false
}
#
variable "geography_group" {
  type        = string
  default     = null
  description = <<DESCRIPTION
  The code for the geography group to filter by. For example, "US" or "Europe".
  DESCRIPTION
  validation {
    condition     = var.geography_group == null ? true : contains(local.supported_geo_groups, var.geography_group)
    error_message = "The geography group must be a supported value (e.g., ${join(", ", local.supported_geo_groups)})."
  }
  sensitive = false
}
#
variable "availability_zones_required" {
  type        = bool
  default     = false
  description = <<DESCRIPTION
  If true, will only include regions that have availability zones.

  If false, will include all regions, regardless of whether they have availability zones.

  The default is false.
  DESCRIPTION
  sensitive   = false
}
#
variable "include_only_recommended_regions" {
  type        = bool
  default     = false
  description = <<DESCRIPTION
  If true, will only include regions that are recommended for new resources.

  If false, will include all regions, regardless of whether they are recommended for new resources.

  The default is false. The 'recommended' attribute is a qualitiative determined by Microsoft.
  DESCRIPTION
  sensitive   = false
}
#