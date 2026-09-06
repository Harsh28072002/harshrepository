rg = {
  "rg1" = {
    rg_name     = "ibm-prod-rg1"
    location = "East US"
  }
  
}

# vm = {
#   "vm1" = {
#     rg_key =  "rg1"
#     cred_key = "cred1"
#     vnet_key = "vnet1"
#     nicname  = "ibm-prod-nic1"
#     vmname   = "ibm-prod-vm1"
#   }
# }

vnet = {
  vnet1 = {
    rg_key = "rg1"
    vnet_name = "ibm-prod-vnet1"
    address_space = ["10.0.0.0/16"]
    nsg_name = "ibm-prod-nsg1"
    snet_name = "ibm-prod-subnet1"
    subnet_address_prefixes = ["10.0.1.0/24"]
    agw_snet_name = "ibm-prod-agw-subnet1"
    agw_subnet_address_prefixes = ["10.0.2.0/24"]

}
}

# cred = {
#   cred1 = {
#     vm_username = "adminuser"
#     vm_password = "P@$$w0rd1234!"
  
# }
# }



capp = {
  capp1 = {
    rg_key = "rg1"
    law_name = "ibm-prod-law1"
    env_name = "ibm-prod-cenv1"
    app_name = "ibm-prod-capp1"
  }
}

agw = {
  agw1 = {
    rg_key = "rg1"
    vnet_key = "vnet1"
    agw_name = "ibm-prod-agw1"
    pip_name = "ibm-prod-pip1"
    }
}




