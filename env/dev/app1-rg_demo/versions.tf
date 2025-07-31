terraform {
  #required_version = ">= 1.8.5"
  required_version = ">= 1.5.7"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.33"
    }
  }
}
provider "azurerm" {
  features {}
}
