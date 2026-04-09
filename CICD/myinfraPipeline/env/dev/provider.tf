provider "azurerm" {
  features {}
  subscription_id = "b36da085-5e4b-452c-85dd-72d6d5b7b684"
}

terraform {
  required_version = ">= 1.3.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}