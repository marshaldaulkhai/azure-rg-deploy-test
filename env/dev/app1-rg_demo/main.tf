resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

resource "azurerm_service_plan" "app_service_plan" {
  name                = var.app_service_plan_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  os_type  = var.app_service_plan_os_type  # "Linux" or "Windows"
  sku_name = var.app_service_plan_sku_name  # e.g., "S1", "B1", "P1v2"

  tags = var.tags
}

# Conditional Linux Web App resource
resource "azurerm_linux_web_app" "linux_webapp" {
  count               = var.app_service_plan_os_type == "Linux" ? 1 : 0

  name                = var.web_app_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.app_service_plan.id

  site_config {
    #linux_fx_version = var.web_app_runtime_stack
  }

  app_settings = var.app_settings

  https_only = true

  tags = var.tags

  identity {
    type = "SystemAssigned"
  }
}

# Conditional Windows Web App resource
resource "azurerm_windows_web_app" "windows_webapp" {
  count               = var.app_service_plan_os_type == "Windows" ? 1 : 0

  name                = var.web_app_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.app_service_plan.id

  site_config {
    application_stack {
      # Customize stack accordingly
      current_stack = "dotnet"
      dotnet_version = var.web_app_runtime_stack
    }
  }

  app_settings = var.app_settings

  https_only = true

  tags = var.tags

  identity {
    type = "SystemAssigned"
  }
}

# Source control: configure only if repo URL provided
resource "azurerm_app_service_source_control" "sourcecontrol" {
  count = length(var.repository_url) > 0 ? 1 : 0

  app_id = (
    var.app_service_plan_os_type == "Linux" ? 
    azurerm_linux_web_app.linux_webapp[0].id : 
    azurerm_windows_web_app.windows_webapp[0].id
  )

  repo_url               = var.repository_url
  branch                 = var.repository_branch
  use_manual_integration = true
}

#########################
# Private Endpoint Support
#########################

resource "azurerm_private_endpoint" "webapp_pe" {
  count               = var.enable_private_endpoint ? 1 : 0

  name                = "${var.web_app_name}-pe"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "${var.web_app_name}-psc"
    private_connection_resource_id = (
      var.app_service_plan_os_type == "Linux" ? 
      azurerm_linux_web_app.linux_webapp[0].id : 
      azurerm_windows_web_app.windows_webapp[0].id
    )

    subresource_names = ["sites"]
    is_manual_connection = false
  }

  tags = var.tags
}

# Role assignment for Private Endpoint to allow network management - requires identity on web apps above
resource "azurerm_role_assignment" "pe_role_assignment" {
  count = var.enable_private_endpoint ? 1 : 0

  scope                = var.private_endpoint_subnet_id

  principal_id = (
    var.app_service_plan_os_type == "Linux" ? 
    azurerm_linux_web_app.linux_webapp[0].identity[0].principal_id :
    azurerm_windows_web_app.windows_webapp[0].identity[0].principal_id
  )

  role_definition_name = "Network Contributor"
}

#########################
# Monitoring: Diagnostic Settings
#########################

resource "azurerm_monitor_diagnostic_setting" "webapp_diag" {
  count = var.enable_monitoring && length(var.log_analytics_workspace_id) > 0 ? 1 : 0

  name                       = "${var.web_app_name}-diag"
  target_resource_id         = (
    var.app_service_plan_os_type == "Linux" ? 
    azurerm_linux_web_app.linux_webapp[0].id : 
    azurerm_windows_web_app.windows_webapp[0].id
  )

  log_analytics_workspace_id = var.log_analytics_workspace_id

  log {
    category = "AppServiceHTTPLogs"
    enabled  = true

    retention_policy {
      days    = 30
      enabled = true
    }
  }

  log {
    category = "AppServiceConsoleLogs"
    enabled  = true

    retention_policy {
      days    = 30
      enabled = true
    }
  }

  metric {
    category = "AllMetrics"
    enabled  = true

    retention_policy {
      days    = 30
      enabled = true
    }
  }

  # Ensure diagnostic setting depends on web app resource to prevent race condition
  depends_on = [
    azurerm_linux_web_app.linux_webapp,
    azurerm_windows_web_app.windows_webapp,
  ]
}
