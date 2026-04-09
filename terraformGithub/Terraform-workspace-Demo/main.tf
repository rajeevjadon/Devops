terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.44.0"
    }
  }
}



provider "azurerm" {
  features {
  }

  subscription_id = "9606fdaa-e143-4ae1-8166-e2f35db55ac0"
}


#local block to define the vm size for different environments

locals {
  vmsize = {
    dev  = "Standard_B1s"
    qa   = "Standard_B1s"
    prod = "Standard_B2s"
  }
}



resource "azurerm_resource_group" "rg" {
  name     = "rg-${terraform.workspace}"
  location = "eastus"

}


resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${terraform.workspace}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]

}


resource "azurerm_subnet" "subnet" {
  name                 = "subnet-${terraform.workspace}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}


resource "azurerm_network_interface" "nic" {
  name                = "nic-${terraform.workspace}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}



resource "azurerm_linux_virtual_machine" "vm" {
  name                = "vm-${terraform.workspace}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = local.vmsize[terraform.workspace]       #fetch the value from the Local Blocks 
  admin_username      = "azureuser"

  network_interface_ids = [
  azurerm_network_interface.nic.id
]

  admin_password                  = "Password1234!"
  disable_password_authentication = false

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
