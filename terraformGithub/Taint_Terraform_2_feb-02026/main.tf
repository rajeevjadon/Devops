terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version  =  "4.60.0"
    }
  }
}




provider "azurerm" {
  features {
  }

  subscription_id = "9606fdaa-e143-4ae1-8166-e2f35db55ac0"
}





resource "azurerm_resource_group" "rg_resource_group_001" {
  name     =     "rg_resource_group_0011"
  location = "eastus"
} 




