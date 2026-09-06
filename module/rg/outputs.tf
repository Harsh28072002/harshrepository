output "rg" {

  value = {
    for key, rg in azurerm_resource_group.RG : key => {
      rg_name     = rg.name
      location = rg.location
    }
  }

}