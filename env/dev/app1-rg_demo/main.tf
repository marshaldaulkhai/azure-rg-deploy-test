# env/dev/app1-rg_demo/main.tf

# Module call for the East US Resource Group (this will use the default 'azurerm' provider configured for 'East US')
module "resource_group_eastus" { # Changed the module instance name for better clarity
  source   = "../../../modules/resource_group" # Path to your resource group module
  name     = var.resource_group_name_eastus    # Use the variable for the East US RG name
  location = "East US"                         # Pass the explicit location to the module's 'location' variable
}

# Module call for the West US Resource Group (this will use the aliased 'azurerm.westus' provider)
module "resource_group_westus" { # New module instance for the West US RG
  source   = "../../../modules/resource_group" # Path to your resource group module
  name     = var.resource_group_name_westus    # Use the variable for the West US RG name
  location = "West US"                         # Pass the explicit location to the module's 'location' variable
  provider = azurerm.westus                    # IMPORTANT: Explicitly tell this module to use the aliased provider
}
