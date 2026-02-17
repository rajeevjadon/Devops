output "app_gateway_id" {
  value = azurerm_application_gateway.app_gateway.id
}

output "backend_pool_id" {
  value = one([
    for pool in azurerm_application_gateway.app_gateway.backend_address_pool :
    pool.id
  ])
}

output "frontend_ip_name" {
  value = azurerm_application_gateway.app_gateway.frontend_ip_configuration[0].name
}
