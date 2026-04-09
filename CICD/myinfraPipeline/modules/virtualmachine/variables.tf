
variable "vms" {
  type = map(object({
    vm_size = string
  }))
}

variable "admin_username" {
  default = "azureuser"
}

variable "admin_password" {
  sensitive = true
}

variable "rg_name" {}
variable "location" {}
variable "subnet_id" {}