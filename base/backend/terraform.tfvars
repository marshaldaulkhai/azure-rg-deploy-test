resource_group_name       = "tfstate-rg-21"
location                  = "eastus"
storage_account_name      = "backend"  # Must be globally unique
container_name            = "tfstate"
account_tier              = "Standard"
account_replication_type  = "LRS"
/*tags = {
  environment = "shared"
  usage       = "terraform-backend"
}
*/
