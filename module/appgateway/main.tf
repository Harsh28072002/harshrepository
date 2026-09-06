resource "azurerm_public_ip" "PIP" {
  for_each = var.agw
  name                = each.value.pip_name
  resource_group_name = var.rg[each.value.rg_key].rg_name
  location            = var.rg[each.value.rg_key].location
  allocation_method   = "Static"
}

# since these variables are re-used - a locals block makes this more maintainable
locals {
  agw_config = {
    for key, agw in var.agw : key => {
      backend_pool  = "${agw.agw_name}-backend-pool"
      frontend_port = "${agw.agw_name}-frontend-port"
      frontend_ip   = "${agw.agw_name}-frontend-ip"
      http_settings = "${agw.agw_name}-http-settings"
      listener      = "${agw.agw_name}-listener"
      routing_rule  = "${agw.agw_name}-routing-rule"
    }
  }
}

resource "azurerm_application_gateway" "AGW" {
  for_each = var.agw
  name                = each.value.agw_name
  resource_group_name = var.rg[each.value.rg_key].rg_name
  location            = var.rg[each.value.rg_key].location

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "ibm-prod-ip-configuration"
    subnet_id = var.agw_subnet_ids[each.value.vnet_key] 
  }

  frontend_port {
    name = local.agw_config[each.key].frontend_port
    port = 80
  }

  frontend_ip_configuration {
    name                 = local.agw_config[each.key].frontend_ip
    public_ip_address_id = azurerm_public_ip.PIP[each.key].id
  }

  backend_address_pool {
    name = local.agw_config[each.key].backend_pool
  }

  backend_http_settings {
    name                  = local.agw_config[each.key].http_settings
    cookie_based_affinity = "Disabled"
    path                  = "/path1/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = local.agw_config[each.key].listener
    frontend_ip_configuration_name = local.agw_config[each.key].frontend_ip
    frontend_port_name             = local.agw_config[each.key].frontend_port
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = local.agw_config[each.key].routing_rule
    priority                   = 9
    rule_type                  = "Basic"
    http_listener_name         = local.agw_config[each.key].listener
    backend_address_pool_name  = local.agw_config[each.key].backend_pool
    backend_http_settings_name = local.agw_config[each.key].http_settings
  }
  
}
