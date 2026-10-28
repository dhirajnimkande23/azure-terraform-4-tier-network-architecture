# Virtual Network Outputs
## Virtual Network Name
output "virtual_network_name" {
  description = "virtual network name"
  value       = azurerm_virtual_network.vnet.name
}
## Virtual Network ID
output "virtual_network_id" {
  description = "Virtual network ID"
  value       = azurerm_virtual_network.vnet.id
}
# Subnet Outputs (We will write for one web subnet and rest all we will ignore for now)
## Subnet Name
output "web_subnet_name" {
  description = "Subnet Name"
  value       = azurerm_subnet.web_name.name
}

## Subnet ID 
output "web_subnet_id" {
  description = "WebTier Subnet ID"
  value       = azurerm_subnet.web_name.id
}

# Network Security Outputs
## Web Subnet NSG Name 
output "web_subnet_nsg_name" {
  description = "WebTier Subnet NSG Name"
  value       = azurerm_network_security_group.web_subnet_nsg.name
}

## Web Subnet NSG ID 
output "web_subnet_nsg_id" {
  description = "WebTier Subnet NSG ID"
  value       = azurerm_network_security_group.web_subnet_nsg.id
}
