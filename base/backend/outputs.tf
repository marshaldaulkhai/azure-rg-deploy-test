output "resource_group_name" {
  value = module.resource_group.name
}
/*
output "storage_account_name" {
  value = module.storage_account.storage_account_name
}

output "container_name" {
  value = module.storage_account.container_name
}

output "connection_string" {
  value     = module.storage_account.primary_connection_string
  sensitive = true
}
*/
