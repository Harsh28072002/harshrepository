module "rg" {
  source = "../../module/rg"
  rg = var.rg
}

# module "vm" {
#   source = "../../module/vm"
#   vm = var.vm
#   rg = module.rg.rg
#   cred = var.cred
#   subnet_ids = module.vnet.subnet_ids
#   }

module "vnet" {
  source = "../../module/vnet"
  vnet = var.vnet
  rg = module.rg.rg
}

module "capp" {
  source = "../../module/capp"
  rg = module.rg.rg
  capp = var.capp
}

module "agw" {
  source = "../../module/appgateway"
  rg = module.rg.rg
  agw = var.agw
  agw_subnet_ids = module.vnet.agw_subnet_ids

}
