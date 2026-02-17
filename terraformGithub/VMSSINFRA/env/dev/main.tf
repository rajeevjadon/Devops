module "module_rg" {
  source   = "../../modules/resource_group"
  for_each = var.rgd

  name     = each.value.name
  location = each.value.location
}

module "module_storage_account" {
  source     = "../../modules/storage_account"
  for_each   = var.stgsd
  depends_on = [module.module_rg]

  name                     = each.value.name
  location                 = each.value.location
  resource_group_name      = module.module_rg[each.value.resource_group_key].rg_name
  account_tier             = each.value.account_tier
  account_replication_type = each.value.account_replication_type
}



module "module_vnet" {
  source   = "../../modules/networking/vnet"
  for_each = var.vnetd

  name                = each.value.name
  location            = each.value.location
  address_space       = each.value.address_space
  resource_group_name = module.module_rg[each.value.resource_group_key].rg_name
}


module "module_subnet" {
  source   = "../../modules/networking/subnet"
  for_each = var.subnetd

  name                 = each.value.name
  address_prefixes     = each.value.address_prefixes
  resource_group_name  = module.module_rg[each.value.resource_group_key].rg_name
  virtual_network_name = module.module_vnet[each.value.vnet_key].vnet_name
}



module "module_nsg" {
  source   = "../../modules/networking/nsg"
  for_each = var.nsgd

  name                = each.value.name
  location            = each.value.location
  resource_group_name = module.module_rg[each.value.resource_group_key].rg_name
  security_rules      = each.value.security_rules
}

resource "azurerm_subnet_network_security_group_association" "this" {
  for_each = var.subnet_nsg_association

  subnet_id                 = module.module_subnet[each.value.subnet_key].subnet_id
  network_security_group_id = module.module_nsg[each.value.nsg_key].nsg_id
}



module "module_public_ip" {
  source   = "../../modules/networking/public_ip"
  for_each = var.public_ipsd

  name                = each.value.name
  location            = each.value.location
  allocation_method   = each.value.allocation_method
  sku                 = each.value.sku
  resource_group_name = module.module_rg[each.value.resource_group_key].rg_name
}


module "module_appgw" {
  source   = "../../modules/networking/app_gtw"
  for_each = var.appgwd

  name                = each.value.name
  location            = each.value.location
  resource_group_name = module.module_rg[each.value.resource_group_key].rg_name

  subnet_id    = module.module_subnet[each.value.subnet_key].subnet_id
  public_ip_id = module.module_public_ip[each.value.public_ip_key].public_ip_id

  sku_name = each.value.sku_name
  sku_tier = each.value.sku_tier
  capacity = each.value.capacity

  frontend_port = each.value.frontend_port
  backend_port  = each.value.backend_port
}



module "module_vmss_frontend" {
  source              = "../../modules/compute/vmss_frontend"
  for_each            = var.virtual_machine_scale_sets_frontend
  vmss_name           = each.value.name
  location            = each.value.location
  resource_group_name = module.module_rg[each.value.resource_group_key].rg_name
  subnet_id           = module.module_subnet[each.value.subnet_key].subnet_id

  instance_count = each.value.instance_count
  vmss_size      = each.value.vmss_size

  admin_username = each.value.admin_username
  admin_password = each.value.admin_password

  image_publisher = each.value.image_publisher
  image_offer     = each.value.image_offer
  image_sku       = each.value.image_sku
  image_version   = each.value.image_version

  os_disk_storage_account_type = each.value.os_disk_storage_account_type
  os_disk_size_gb              = each.value.os_disk_size_gb
  os_disk_caching              = each.value.os_disk_caching

  nic_name = each.value.nic_name
  tags     = each.value.tags
}



module "module_vmss_backend" {
  source              = "../../modules/compute/vmss_frontend"
  for_each            = var.virtual_machine_scale_sets_backend
  vmss_name           = each.value.name
  location            = each.value.location
  resource_group_name = module.module_rg[each.value.resource_group_key].rg_name
  subnet_id           = module.module_subnet[each.value.subnet_key].subnet_id

  instance_count = each.value.instance_count
  vmss_size      = each.value.vmss_size

  admin_username = each.value.admin_username
  admin_password = each.value.admin_password

  image_publisher = each.value.image_publisher
  image_offer     = each.value.image_offer
  image_sku       = each.value.image_sku
  image_version   = each.value.image_version

  os_disk_storage_account_type = each.value.os_disk_storage_account_type
  os_disk_size_gb              = each.value.os_disk_size_gb
  os_disk_caching              = each.value.os_disk_caching

  nic_name = each.value.nic_name
  tags     = each.value.tags
}
