module "resource_group" {
  source              = "../../modules/resource_group"
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}

module "storage_account" {
  source                  = "../../modules/storage_account"
  storage_account_name    = var.storage_account_name
  container_name          = var.container_name
  resource_group_name     = module.resource_group.name
  location                = var.location
  account_tier            = var.account_tier
  account_replication_type = var.account_replication_type
  tags                    = var.tags
}
