# cf . https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group
#tfsec:ignore:azure-network-no-public-ingress
#tfsec:ignore:azure-network-disable-rdp-from-internet
resource "azurerm_network_security_group" "nsg" {
  name                = azurecaf_name.nsg.result
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "RDP"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# cf . https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association
resource "azurerm_subnet_network_security_group_association" "association" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}