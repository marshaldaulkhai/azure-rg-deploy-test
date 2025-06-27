# modules/storage_account/outputs.tf

output "storage_account_name" {
  description = "The name of the created storage account"
  value       = azurerm_storage_account.this.name
}

output "resource_group_location" {
  description = "The location of the created resource group"
  value       = azurerm_resource_group.this.location
}

output "container_name" {
  description = "The location of the created resource group"
  value       = azurerm_storage_container.this.name
}


output "connection_string" {
  description = "The location of the created resource group"
  value       = azurerm_storage_account.this.primary_connection_string
}
