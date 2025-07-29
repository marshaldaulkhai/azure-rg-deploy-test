terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  required_version = ">= 0.14.9"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "example-app-rg"
  location = "East US"
}

resource "azurerm_service_plan" "app_service_plan" {
  name                = "example-appservice-plan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku_name            = "S1"
  os_type             = "Windows" # Or "Linux"
}


  app_settings = {
    "SOME_KEY" = "some-value"
  }
}
