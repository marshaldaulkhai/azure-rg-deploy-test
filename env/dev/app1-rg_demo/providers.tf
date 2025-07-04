# env/dev/app1-rg_demo/providers.tf

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  required_version = ">= 1.0.0"
}

# Configure the default AzureRM Provider for resources in East US
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id # Get subscription ID from variable
  location        = "East US"           # Set the default region for this provider instance
}

# Configure an aliased AzureRM Provider for resources in West US
provider "azurerm" {
  alias           = "westus"            # Give this provider configuration an alias
  features {}
  subscription_id = var.subscription_id # Use the same subscription ID
  location        = "West US"           # Set the specific region for the aliased provider
}
