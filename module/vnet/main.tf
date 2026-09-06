resource "azurerm_network_security_group" "NSG" {
  for_each = var.vnet
  name = each.value.nsg_name
  location = var.rg[each.value.rg_key].location
  resource_group_name = var.rg[each.value.rg_key].rg_name
    security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_virtual_network" "VNET" {
  for_each = var.vnet
  name   = each.value.vnet_name
  address_space       = each.value.address_space
  location = var.rg[each.value.rg_key].location
  resource_group_name = var.rg[each.value.rg_key].rg_name
    
  }

resource "azurerm_subnet" "SNET" {
  for_each = var.vnet
  name                 = each.value.snet_name
  resource_group_name  = var.rg[each.value.rg_key].rg_name
  virtual_network_name = azurerm_virtual_network.VNET[each.key].name
  address_prefixes     = each.value.subnet_address_prefixes
  
}

resource "azurerm_subnet" "AGW_SNET" {
  for_each = var.vnet
  name = each.value.agw_snet_name 
  resource_group_name  = var.rg[each.value.rg_key].rg_name
  virtual_network_name = azurerm_virtual_network.VNET[each.key].name   
  address_prefixes     = each.value.agw_subnet_address_prefixes
}