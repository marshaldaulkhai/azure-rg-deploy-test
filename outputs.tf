# outputs.tf

output "rg_name" {
  value = module.resource_group.resource_group_name
}

output "rg_location" {
  value = module.resource_group.resource_group_location
}
