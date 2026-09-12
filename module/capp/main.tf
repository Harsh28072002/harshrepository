resource "azurerm_log_analytics_workspace" "LAW" {
  for_each            = var.capp
  name                = each.value.law_name
  location            = var.rg[each.value.rg_key].location
  resource_group_name = var.rg[each.value.rg_key].rg_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_container_app_environment" "CENV" {
  for_each                   = var.capp
  name                       = each.value.env_name
  location                   = var.rg[each.value.rg_key].location
  resource_group_name        = var.rg[each.value.rg_key].rg_name
  logs_destination           = "log-analytics"
  log_analytics_workspace_id = azurerm_log_analytics_workspace.LAW[each.key].id
}


resource "azurerm_container_app" "CAPP" {
  for_each                     = var.capp
  name                         = each.value.app_name
  container_app_environment_id = azurerm_container_app_environment.CENV[each.key].id
  resource_group_name          = var.rg[each.value.rg_key].rg_name
  revision_mode                = "Single"

  template {
    container {
      name   = "examplecontainerapp"
      image  = "mcr.microsoft.com/k8se/quickstart:latest"
      cpu    = 0.25
      memory = "0.5Gi"
    }
  }
}