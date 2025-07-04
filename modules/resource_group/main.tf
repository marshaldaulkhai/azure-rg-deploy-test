# modules/resource_group/main.tf

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}

resource "azurerm_resource_group" "main" {
  name     = var.name
  location = var.location # This 'location' is correct here; it's the resource's argument
}