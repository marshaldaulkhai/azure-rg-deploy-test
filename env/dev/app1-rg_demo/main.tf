# env/dev/app1-rg_demo/main.tf

# Module call for the East US Resource Group (this will use the default 'azurerm' provider configured for 'East US')
module "resource_group_eastus" {
  source   = "../../../modules/resource_group"
  name     = var.resource_group_name_eastus
  location = "East US"
  # No 'providers' block needed here, as it uses the default 'azurerm' provider
}

# Module call for the West US Resource Group (this will use the aliased 'azurerm.westus' provider)
module "resource_group_westus" {
  source   = "../../../modules/resource_group"
  name     = var.resource_group_name_westus
  location = "West US"

  # IMPORTANT CORRECTION: Use the 'providers' block to map the provider
  providers = {
    azurerm = azurerm.westus # This maps the 'azurerm' provider *inside the module* to our 'azurerm.westus' alias
  }
}
