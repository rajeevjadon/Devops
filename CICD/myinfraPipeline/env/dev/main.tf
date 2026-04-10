module "resource_group" {
  source   = "../../modules/resource_group"
  rg_name  = var.rg_name
  location = var.location
}



#This is the Simran RG
module "bhagat_group" {
  source   = "../../modules/resource_group"
  rg_name  = "bhagarRG"
  location = var.location
}


module "network" {
  source     = "../../modules/network"
  depends_on = [module.resource_group]

  rg_name   = module.resource_group.rg_name
  location  = var.location
  vnet_name = var.vnet_name
}

module "vm" {
  source     = "../../modules/virtualmachine"
  depends_on = [module.network]

  rg_name        = module.resource_group.rg_name
  location       = var.location
  subnet_id      = module.network.subnet_id
  vms            = var.vms
  admin_password = var.admin_password
}