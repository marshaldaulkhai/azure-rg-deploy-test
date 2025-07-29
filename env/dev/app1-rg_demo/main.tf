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
  
  sku_name = "S1"           # Standard S1 plan
  os_type  = "Windows"      # Change to "Linux" if needed
}

resource "azurerm_app_service" "app_service" {
  name                = "example-webapp-12345"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  
  app_service_plan_id = azurerm_service_plan.app_service_plan.id  # Correct argument name here

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
    # For Linux apps:
    # linux_fx_version = "PYTHON|3.8"
  }

  app_settings = {
    "SOME_KEY" = "some-value"
  }
}
