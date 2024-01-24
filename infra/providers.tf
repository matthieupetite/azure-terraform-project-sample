terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.83.0"
    }
    azurecaf = {
      source  = "aztfmod/azurecaf"
      version = "=1.2.26"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  subscription_id = "27ec515c-1701-4005-a267-b5f94dba4c8f"
  features {}
}

provider "azurecaf" {
}
