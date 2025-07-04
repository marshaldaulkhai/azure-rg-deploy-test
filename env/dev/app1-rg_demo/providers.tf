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
  subscription_id = var.subscription_id
  region          = "East US"           # CORRECTED: Use 'region' here
}

# Configure an aliased AzureRM Provider for resources in West US
provider "azurerm" {
  alias           = "westus"
  features {}
  subscription_id = var.subscription_id
  region          = "West US"           # CORRECTED: Use 'region' here
}
