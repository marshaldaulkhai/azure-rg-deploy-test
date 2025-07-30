output "web_app_default_hostname" {
  value = var.app_service_plan_os_type == "Linux" ? azurerm_linux_web_app.linux_webapp[0].default_hostname : azurerm_windows_web_app.windows_webapp[0].default_hostname
}

output "app_service_plan_id" {
  value = azurerm_service_plan.app_service_plan.id
}

output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "private_endpoint_id" {
  value = var.enable_private_endpoint ? azurerm_private_endpoint.webapp_pe[0].id : ""
}

output "diagnostic_setting_id" {
  value = (var.enable_monitoring && length(var.log_analytics_workspace_id) > 0) ? azurerm_monitor_diagnostic_setting.webapp_diag[0].id : ""
}
