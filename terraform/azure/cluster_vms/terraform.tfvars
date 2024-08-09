availability_zones_required           = true
azure_primary_region                  = "centralus"
azurerm_resource_group_name           = "rg-demonstration"
azurerm_virtual_network_address_space = ["10.0.0.0/16"]
environment                           = "dev"
geography_group                       = "US"
include_only_recommended_regions      = true
server_ip_addressess = [
  #"10.0.0.191", 
  #"10.0.0.192", 
  "10.0.0.193"
]
agent_ip_addresses = [
  #"10.0.0.194", 
  #"10.0.0.195", 
  "10.0.0.196"
]
custom_tags = {
  environment = "dev"
  project     = "terraform-azure"
  owner       = "devops"
}
