

resource "azurerm_resource_group" "resourc_group" {
  name = var.resource_group_name
  location = var.resource_group_location
}