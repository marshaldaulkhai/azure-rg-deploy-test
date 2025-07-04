# env/dev/app1-rg_demo/main.tf

# Module call for the East US Resource Group (this will use the default 'azurerm' provider)
module "resource_group_eastus" {
  source   = "../../../modules/resource_group"
  name     = var.resource_group_name_eastus
  location = "East US"
}

# Module call for the West US Resource Group (this will now use the aliased 'azurerm.audit_access' provider)
module "resource_group_westus" {
  source   = "../../../modules/resource_group"
  name     = var.resource_group_name_westus
  location = "West US"
  providers = {
    azurerm = azurerm.audit_access # Explicitly map to the aliased provider
  }
}