
variable "rgd" {
  description = "Map of Resource Groups Variable Decleration"
  type = map(object({
    name     = string
    location = string
  }))
}


variable "stgsd" {
  type =  map(object({
    name = string 
    location = string 
    resource_group_key = string 
    account_tier = string 
    account_replication_type = string 
  }))
}


variable "vnetd" {
  type = map(object({
    name               = string
    resource_group_key = string
    location           = string
    address_space      = list(string)
  }))
}




variable "subnetd" {
  description = "Map of subnets"
  type = map(object({
    name                = string
    address_prefixes    = list(string)
    resource_group_key  = string
    vnet_key            = string
  }))
}


variable "nsgd" {
  description = "Map of Network Security Groups"
  type = map(object({
    name               = string
    location           = string
    resource_group_key = string

    security_rules = list(object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string
    }))
  }))
}

variable "subnet_nsg_association" {
  description = "Subnet to NSG association"
  type = map(object({
    subnet_key = string
    nsg_key    = string
  }))
}


variable "public_ipsd" {
  type = map(object({
    name               = string
    location           = string
    resource_group_key = string
    allocation_method  = string  //Static / Dynamic
    sku                = string  // Dynamic / Basic 
  }))
}




variable "appgwd" {
  type = map(object({
    name               = string
    location           = string
    resource_group_key = string
    subnet_key         = string
    public_ip_key      = string   # 👈 REQUIRED

    sku_name = string
    sku_tier = string
    capacity = number

    frontend_port = number
    backend_port  = number
  }))
}


variable "virtual_machine_scale_sets_frontend" {
  description = "Map of Frontend VM Scale Sets configuration"
  type = map(object({
    name               = string
    resource_group_key = string
    subnet_key         = string
    location           = string
    instance_count     = number
    vmss_size            = string
 
    admin_username = string
    admin_password = string

    image_publisher = string
    image_offer     = string
    image_sku       =string
    image_version   = string

    os_disk_storage_account_type = string
    os_disk_size_gb              = number
    os_disk_caching              = string

    nic_name = string

    tags = map(string)
  }))
}




variable "virtual_machine_scale_sets_backend" {
  description = "Map of Backend  VM ts configuration"
  type = map(object({
    name               = string
    resource_group_key = string
    subnet_key         = string
    location           = string
    instance_count     = number
    vmss_size            = string
     admin_username = string
    admin_password = string
    image_publisher = string
    image_offer     = string
    image_sku       =string
    image_version   = string
    os_disk_storage_account_type = string
    os_disk_size_gb              = number
    os_disk_caching              = string
    nic_name = string
    tags = map(string)
  }))
}


variable "load_balancers" {
  type = map(object({
    lb_name               = string
    location              = string
    resource_group_key    = string
    frontend_ip           = string
    public_ip_key         = string
    backend_pool_name     = string
    probe_name            = string
    lb_rule_name          = string
    ip_configuration_name = string
  }))
}



























# variable "stgs" {
#     type = map(object({
#         name = string
#         location = string
#         resource_group_key = string 
#         account_tier = string 
#         account_replication_type  =  string 
#     }))
# }


# variable "vnets" {
#     type = map(object({
#         name = string
#         location = string
#         resource_group_key = string 
#         address_space = list(string)
#         dns_servers = list(string)
#     }))
# }


# variable "subnets" {
#     type = map(object({
#         name = string
#         location = string
#         vnet_key =  string 
#         resource_group_key = string 
#         address_prefixes = list(string)
#     }))
# }



# variable "nsgs" {
#   type = map(object({
#     name               = string
#     location           = string
#     resource_group_key = string

#     security_rules = list(object({
#       name                       = string
#       priority                   = number
#       direction                  = string
#       access                     = string
#       protocol                   = string
#       source_port_range          = string
#       destination_port_range     = string
#       source_address_prefix      = string
#       destination_address_prefix = string
#     }))
#   }))
# }


# variable "public_ips" {
#   type = map(object({
#     name               = string
#     location           = string
#     resource_group_key = string
#     allocation_method  = string
#     sku                = string
#   }))
# }








