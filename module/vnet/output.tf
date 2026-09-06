output "subnet_ids" {
  value = {
    for key, subnet in azurerm_subnet.SNET :
    key => subnet.id
  }
}

output "agw_subnet_ids" {
  value = {
    for key, subnet in azurerm_subnet.AGW_SNET :
    key => subnet.id
  }
}

