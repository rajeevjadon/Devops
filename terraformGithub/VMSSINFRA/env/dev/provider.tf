terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.44.0"
    }
  }
}


provider "azurerm" {
  features {}
  subscription_id = "9606fdaa-e143-4ae1-8166-e2f35db55ac0"
}
