
# This file configures the AzureRM provider for Terraform.
# It specifies the required provider version and configures the provider with the necessary subscription ID.
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

# Configure the AzureRM provider
# Ensure you have the correct subscription ID   
provider "azurerm" {
  subscription_id = "4ceed8b2-1642-4938-be22-14241957ae64"
}