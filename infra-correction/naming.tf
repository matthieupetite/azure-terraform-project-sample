# cf . https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/resources/azurecaf_name
resource "azurecaf_name" "rg" {
  name          = var.resource_name
  resource_type = "azurerm_resource_group"
  suffixes      = [var.location_abbreviation, "001"]
  clean_input   = true
}

# cf . https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/resources/azurecaf_name
resource "azurecaf_name" "vnet" {
  name          = var.resource_name
  resource_type = "azurerm_virtual_network"
  suffixes      = [var.location_abbreviation, "001"]
  clean_input   = true
}

# cf . https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/resources/azurecaf_name
resource "azurecaf_name" "subnet" {
  name          = var.resource_name
  resource_type = "azurerm_subnet"
  suffixes      = [var.location_abbreviation, "001"]
  clean_input   = true
}

# cf . https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/resources/azurecaf_name
resource "azurecaf_name" "vm" {
  name          = var.resource_name
  resource_type = "azurerm_windows_virtual_machine"
  suffixes      = [var.location_abbreviation, "001"]
  clean_input   = true
}

# cf . https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/resources/azurecaf_name
resource "azurecaf_name" "nic" {
  name          = var.resource_name
  resource_type = "azurerm_network_interface"
  suffixes      = [var.location_abbreviation, "001"]
  clean_input   = true
}

# cf . https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/resources/azurecaf_name
resource "azurecaf_name" "publicip" {
  name          = var.resource_name
  resource_type = "azurerm_public_ip"
  suffixes      = [var.location_abbreviation, "001"]
  clean_input   = true
}

# cf . https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/resources/azurecaf_name
resource "azurecaf_name" "nsg" {
  name = var.resource_name
  resource_type = "azurerm_network_security_group"
  suffixes = [var.location_abbreviation, "001"]
}