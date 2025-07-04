# modules/resource_group/main.tf

# Add this block at the top of your module's main.tf file
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      # You can optionally specify a version constraint here if your module
      # has specific compatibility requirements, e.g., version = "~> 3.0"
    }
  }
}

resource "azurerm_resource_group" "main" {
  name     = var.name
  location = var.location
}
