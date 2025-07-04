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

# Configure the single AzureRM Provider.
# The region for resources will be specified directly on the resources themselves.
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id # Still need to pass your subscription ID here
}