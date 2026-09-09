resource "azurerm_network_interface" "NIC" {
  for_each            = var.vm
  name                = each.value.nicname
  location            = var.rg[each.value.rg_key].location
  resource_group_name = var.rg[each.value.rg_key].rg_name


  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_ids[each.value.vnet_key]
    private_ip_address_allocation = "Dynamic"
  }
}


resource "azurerm_windows_virtual_machine" "VM" {
  for_each            = var.vm
  name                = each.value.vmname
  resource_group_name = var.rg[each.value.rg_key].rg_name
  location            = var.rg[each.value.rg_key].location
  size                = "Standard_D2ads_v7"
  admin_username      = var.cred[each.value.cred_key].vm_username
  admin_password      = var.cred[each.value.cred_key].vm_password
  patch_mode          = "AutomaticByPlatform"
  network_interface_ids = [
    azurerm_network_interface.NIC[each.key].id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2025-datacenter-azure-edition"
    version   = "latest"
  }
}