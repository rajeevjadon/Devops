rg_name   = "rajeev-rg"
location  = "Central India"
vnet_name = "rajeev-vnet"

vms = {
  frontend = {
    vm_size = "Standard_B1s"
  }
  backend = {
    vm_size = "Standard_B1s"
  }
}

admin_password = "Apple@123"