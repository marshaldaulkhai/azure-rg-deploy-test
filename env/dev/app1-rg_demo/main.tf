# env/dev/app1-rg_demo/main.tf

# Module call for the East US Resource Group
module "resource_group_eastus" {
  source   = "../../../modules/resource_group"
  name     = var.resource_group_name_eastus
  location = "East US" # This location will be used for the RG created by the module
}

# Module call for the West US Resource Group
module "resource_group_westus" {
  source   = "../../../modules/resource_group"
  name     = var.resource_group_name_westus
  location = "West US" # This location will be used for the RG created by the module
  # REMOVE THE 'providers' BLOCK ENTIRELY FROM HERE
}