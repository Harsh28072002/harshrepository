rg = {
  "rg1" = {
    rg_name  = "ibm-qa-rg1"
    location = "west europe"
  }

}

# vm = {
#   "vm1" = {
#     rg_key =  "rg1"
#     cred_key = "cred1"
#     vnet_key = "vnet1"
#     nicname  = "ibm-qa-nic1"
#     vmname   = "ibm-qa-vm1"
#   }
# }

vnet = {
  vnet1 = {
    rg_key                      = "rg1"
    vnet_name                   = "ibm-qa-vnet1"
    address_space               = ["10.0.0.0/16"]
    nsg_name                    = "ibm-qa-nsg1"
    snet_name                   = "ibm-qa-subnet1"
    subnet_address_prefixes     = ["10.0.2.0/24"]
    agw_snet_name               = "ibm-qa-agw-subnet1"
    agw_subnet_address_prefixes = ["10.0.3.0/24"]

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
    rg_key   = "rg1"
    law_name = "ibm-qa-law1"
    env_name = "ibm-qa-cenv1"
    app_name = "ibm-qa-capp1"
  }
}

agw = {
  agw1 = {
    rg_key   = "rg1"
    vnet_key = "vnet1"
    agw_name = "ibm-qa-agw1"
    pip_name = "ibm-qa-pip1"
  }
}
