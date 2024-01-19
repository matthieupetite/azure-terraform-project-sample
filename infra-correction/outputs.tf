output "rg_name" {
  description = "This is the output of the resource group name"
  value       = azurerm_resource_group.rg.name
}

output "rg_location" {
  description = "This is the output of the resource group location"
  value       = azurerm_resource_group.rg.location
}

output "public_ip" {
  description = "This is the output of the public ip"
  value       = azurerm_public_ip.publicip.ip_address
}