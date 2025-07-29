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

resource "azurerm_app_service_plan" "app_service_plan" {
  name                = "example-appservice-plan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku {
    tier = "Standard"
    size = "S1"
  }

  # For Linux web apps, uncomment the next two lines:
  # kind     = "Linux"
  # reserved = true
}

resource "azurerm_app_service" "app_service" {
  name                = "example-webapp-12345"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.app_service_plan.id

  site_config {
    dotnet_framework_version = "v4.0"     # For .NET apps
    scm_type                 = "LocalGit" # Set deployment option
    # For Linux apps, use for example:
    # linux_fx_version = "PYTHON|3.8"
  }

  app_settings = {
    "SOME_KEY" = "some-value"
  }
}
