data "azurerm_client_config" "current" {
}
#
data "azapi_resource_action" "compute_provider" {
  type                   = "Microsoft.Resources/subscriptions@2023-07-01"
  action                 = "providers/Microsoft.Compute"
  method                 = "GET"
  resource_id            = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
  response_export_values = ["resourceTypes"]
}
#
data "azapi_resource_action" "locations" {
  type                   = "Microsoft.Resources/subscriptions@2022-12-01"
  action                 = "locations"
  method                 = "GET"
  resource_id            = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
  response_export_values = ["value"]
}
#