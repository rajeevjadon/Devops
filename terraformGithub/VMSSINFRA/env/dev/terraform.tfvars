rgd = {
  dev_rgd = {
    name     = "infra_rajeev"
    location = "Central India"
  }
}


#variable assign value in form of map of string  
stgsd = { 
  dev_stg = {
    name = "devstgrajeev01"

    location = "Central India"
    resource_group_key = "dev_rgd"
    account_tier = "Standard"
    account_replication_type =  "LRS"

  }
}


vnetd = {
  dev_vnetd = {
    name               = "dev_vnet"
    location           = "Central India"
    resource_group_key = "dev_rgd"
    address_space      = ["10.0.0.0/16"]
  }
}


subnetd = {
  dev_appgw = {
    name               = "appgw_subnet"
    address_prefixes   = ["10.0.1.0/24"]
    resource_group_key = "dev_rgd"
    vnet_key           = "dev_vnetd"
  }

  dev_frontend = {
    name               = "frontend_subnet"
    address_prefixes   = ["10.0.2.0/24"]
    resource_group_key = "dev_rgd"
    vnet_key           = "dev_vnetd"
  }

  dev_backend = {
    name               = "backend_subnet"
    address_prefixes   = ["10.0.3.0/24"]
    resource_group_key = "dev_rgd"
    vnet_key           = "dev_vnetd"
  }

  dev_bastion = {
    name               = "AzureBastionSubnet"
    address_prefixes   = ["10.0.4.0/26"]
    resource_group_key = "dev_rgd"
    vnet_key           = "dev_vnetd"
  }
}







nsgd = {
  nsg_appgw = {
    name               = "nsg-appgw"
    location           = "Central India"
    resource_group_key = "dev_rgd"

    security_rules = [
      {
        name                       = "Allow-HTTP-HTTPS"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "65200-65535"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    ]
  }

  nsg_frontend = {
    name               = "nsg-frontend"
    location           = "Central India"
    resource_group_key = "dev_rgd"

    security_rules = [
      {
        name                       = "Allow-AppGW"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "10.0.1.0/24"
        destination_address_prefix = "*"
      }
    ]
  }

  nsg_backend = {
    name               = "nsg-backend"
    location           = "Central India"
    resource_group_key = "dev_rgd"

    security_rules = [
      {
        name                       = "Allow-Frontend"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "8080"
        source_address_prefix      = "10.0.2.0/24"
        destination_address_prefix = "*"
      }
    ]
  }

  nsg_bastion = {
    name               = "nsg-bastion"
    location           = "Central India"
    resource_group_key = "dev_rgd"

    security_rules = [
      {
        name                       = "Allow-SSH-RDP"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "9"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    ]
  }
}

subnet_nsg_association = {
  appgw = {
    subnet_key = "dev_appgw"
    nsg_key    = "nsg_appgw"
  }

  frontend = {
    subnet_key = "dev_frontend"
    nsg_key    = "nsg_frontend"
  }

  backend = {
    subnet_key = "dev_backend"
    nsg_key    = "nsg_backend"
  }

  bastion = {
    subnet_key = "dev_bastion"
    nsg_key    = "nsg_bastion"
  }
}




public_ipsd = {
  dev_appgw_pipd = {
    name               = "pip-appgw"
    location           = "Central India"
    resource_group_key = "dev_rgd"
    allocation_method  = "Static"
    sku                = "Standard"
  }
}

appgwd = {
  dev_appgw = {
    name               = "dev-appgw"
    location           = "Central India"
    resource_group_key = "dev_rgd"
    subnet_key         = "dev_appgw"
    public_ip_key      = "dev_appgw_pipd" # ✅ ADD THIS (must match public_ip map key)
    sku_name           = "Standard_v2"
    sku_tier           = "Standard_v2"
    capacity           = 2
    frontend_port      = 80
    backend_port       = 80
  }
}



virtual_machine_scale_sets_frontend = {
  "frontend_vmss" = {
    name               = "prod-frontend-vmss"
    resource_group_key = "dev_rgd"
    subnet_key         = "dev_frontend"
    location           = "Central India"
    instance_count     = 2
    vmss_size          = "Standard_D2s_v3"

    admin_username = "frontend_user"
    admin_password = "Password@123!"

    image_publisher = "Canonical"
    image_offer     = "0001-com-ubuntu-server-focal"
    image_sku       = "20_04-lts"
    image_version   = "latest"

    os_disk_storage_account_type = "Standard_LRS"
    os_disk_size_gb              = 30
    os_disk_caching              = "ReadWrite"

    nic_name = "frontend-vmss-nic"

    tags = {
      environment = "prod"
      layer       = "frontend"
      project     = "vm_infra"
      owner       = "Rajeev Singh"
    }
  }
}




virtual_machine_scale_sets_backend = {
  "backend_vmss" = {
    name               = "prod-backend-vmss"
    resource_group_key = "dev_rgd"
    subnet_key         = "dev_backend"
    location           = "Central India"
    instance_count     = 2
    vmss_size          = "Standard_D2s_v3"

    admin_username = "backend_user"
    admin_password = "Password@123!"

    image_publisher = "Canonical"
    image_offer     = "0001-com-ubuntu-server-focal"
    image_sku       = "20_04-lts"
    image_version   = "latest"

    os_disk_storage_account_type = "Standard_LRS"
    os_disk_size_gb              = 30
    os_disk_caching              = "ReadWrite"

    nic_name = "backend-vmss-nic"

    tags = {
      environment = "prod"
      layer       = "backend"
      project     = "vm_infra"
      owner       = "Rajeev Singh"
    }
  }
}


load_balancers = {
  devloadbalancer = {
    lb_name               = "dev-loadbalancer"
    location              = "centralindia"
    resource_group_key    = "dev_rgd"
    frontend_ip           = "CSX-dev-frontend-ip"
    public_ip_key         = "dev_appgw_pipd"
    backend_pool_name     = "dev-backend-pool"
    probe_name            = "dev-probe"
    lb_rule_name          = "dev-lb-rule"
    ip_configuration_name = "ipconfig1"
  }
}





# vnets = {
#   "dev_vnet" = {
#     name          = "dev_vnet"
#     location      = "Central India"
#     address_space = ["10.0.0.0/16"]
#     dns_servers   = ["10.0.0.1", "10.0.0.2"]
#     resource_group_key = "dev_rg"
#   }
# }

# subnets = {
#   "dev_subnets" = {
#     name          = "dev_subnets-vmss"
#     location      = "Central India"
#     vnet_key = "dev_vnet"
#     resource_group_key = "dev_rg"
#     address_prefixes = ["10.0.0.0/24"]
#   }
# }


# stgs = {
#   dev_stg = {
#     name = "devstg"
#     location = "Central India"
#     resource_group_key = "dev_rg"
#     account_tier = "Standard"
#     account_replication_type = "LRS"

#   }
# }


