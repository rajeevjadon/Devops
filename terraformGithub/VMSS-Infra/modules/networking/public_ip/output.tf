output "name" {
  value = azurerm_public_ip.public_ip.name
}

output "public_ip_id" {
  description = "ID of the Public IP"
  value       = azurerm_public_ip.public_ip.id
}

output "public_ip_address" {
  description = "Public IP address"
  value       = azurerm_public_ip.public_ip.ip_address
}
