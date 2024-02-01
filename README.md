[# Starter Kit Terraform

## Overview

This repo aims to help user to start with terraform on azure by providing studends a small project ecosystem and a case study to implement.

## Case Studies

The current case studies aims to deploy a windows datacenter 2019.

The architecture we aim to build is the following:

!\[architecture\](./doc/schema.png)



## Pre-requisites

In order to be efficient right away and make sure you have the right tooling, we based our starter kit on a **devcontainer**
running all the good stuff!
Therefore PLEASE use it!😎

## Quick start

### Prepare your environment

- Open the repository using the devcontainer in Visual Studio Code

- Run the following command to get the source code and install the necessary node modules after having forked the repository.

  ```bash
  npm install
  ```

- Login to Azure

  ```bash
  az login
  az account set --suscription <subscription ID> # if you have several subscriptions in your tenant
  ```

- Create you git branch

  ```bash
  git checkout -b <branch>
  ```

- Rename the infra folder to infra-backup and create an new infra folder

### Code your infrastructure

#### Create your launchpad

- create a storage account in your subscription and create a container in it with private access.

#### Write your code

  1. Create a provider.tf file

  ```terraform
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
    subscription_id = ""
    features {}
  }

  provider "azurecaf" {
  }
  ```

  2. Create a main.tf file

  ```terraform
    /**
  * # Main title
  *
  * Everything in this comment block will get extracted.
  *
  * You can put simple text or complete Markdown content
  * here. Subsequently if you want to render AsciiDoc format
  * you can put AsciiDoc compatible content in this comment
  * block.
  * Start implementing your terraform code here 😎
  */

  locals {
    tags = {
      "env"  = "training"
      "team" = "petroineos"
      "date" = var.localdate
    }
  }

  resource "azurerm_resource_group" "rg" {
    name     = azurecaf_name.rg.result
    location = var.location
    tags     = local.tags
  }
  ```

  3. Create an naming.tf file

  ```
  # cf . https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/resources/azurecaf_name
  resource "azurecaf_name" "rg" {
    name          = var.resource_name
    resource_type = "azurerm_resource_group"
    suffixes      = \[var.location_abbreviation, "001"\]
    clean_input   = true
  }

  # cf . https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/resources/azurecaf_name
  resource "azurecaf_name" "vnet" {
    name          = var.resource_name
    resource_type = "azurerm_virtual_network"
    suffixes      = \[var.location_abbreviation, "001"\]
    clean_input   = true
  }

  # cf . https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/resources/azurecaf_name
  resource "azurecaf_name" "subnet" {
    name          = var.resource_name
    resource_type = "azurerm_subnet"
    suffixes      = \[var.location_abbreviation, "001"\]
    clean_input   = true
  }

  # cf . https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/resources/azurecaf_name
  resource "azurecaf_name" "vm" {
    name          = var.resource_name
    resource_type = "azurerm_windows_virtual_machine"
    suffixes      = \[var.location_abbreviation, "001"\]
    clean_input   = true
  }

  # cf . https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/resources/azurecaf_name
  resource "azurecaf_name" "nic" {
    name          = var.resource_name
    resource_type = "azurerm_network_interface"
    suffixes      = \[var.location_abbreviation, "001"\]
    clean_input   = true
  }

  # cf . https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/resources/azurecaf_name
  resource "azurecaf_name" "publicip" {
    name          = var.resource_name
    resource_type = "azurerm_public_ip"
    suffixes      = \[var.location_abbreviation, "001"\]
    clean_input   = true
  }

  # cf . https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/resources/azurecaf_name
  resource "azurecaf_name" "nsg" {
    name          = var.resource_name
    resource_type = "azurerm_network_security_group"
    suffixes      = \[var.location_abbreviation, "001"\]
  }
  ```

  4. Create a network.tf file

    ```  
    # cf . https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network
    resource "azurerm_virtual_network" "vnet" {
      name                = azurecaf_name.vnet.result
      resource_group_name = azurerm_resource_group.rg.name
      location            = var.location
      address_space       = \["192.168.0.0/24"\]
      tags                = local.tags
    }

    # cf . https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet
    resource "azurerm_subnet" "subnet" {
      name                 = azurecaf_name.subnet.result
      resource_group_name  = azurerm_resource_group.rg.name
      virtual_network_name = azurerm_virtual_network.vnet.name
      address_prefixes     = \["192.168.0.0/25"\]
    }

    # cf . https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip
    resource "azurerm_public_ip" "publicip" {
      name                = azurecaf_name.publicip.result
      location            = var.location
      resource_group_name = azurerm_resource_group.rg.name
      allocation_method   = "Dynamic"
    }

    # cf . https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface
    resource "azurerm_network_interface" "nic" {
      name                = azurecaf_name.nic.result
      location            = var.location
      resource_group_name = azurerm_resource_group.rg.name

      ip_configuration {
        name                          = "internal"
        subnet_id                     = azurerm_subnet.subnet.id
        public_ip_address_id          = azurerm_public_ip.publicip.id
        private_ip_address_allocation = "Dynamic"
      }
    }
    ```

  5. Create a security.tf file

  ```
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
  ```

  6. create a variable.tf file

  ```
  variable "location" {
    type        = string
    description = "Location of the resources"
    default     = "North Europe"
  }

  variable "location_abbreviation" {
    type        = string
    description = "Location abbreviation of the resources"
    default     = "northeu"
  }

  variable "localdate" {
    type        = string
    description = "Local Date"
    default     = "15122022"
  }

  variable "resource_name" {
    type    = string
    default = "default_resource_name"
  }

  variable "admin_password" {
    type      = string
    default   = "default_admin_password"
    sensitive = true
  }

  variable "admin_username" {
    type    = string
    default = "default_admin_username"
  }
  ```

  7. create a virtualmachine.tf file
   
  ```
  # cf . https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine
  resource "azurerm_windows_virtual_machine" "vm" {
    name                  = azurecaf_name.vm.result
    resource_group_name   = azurerm_resource_group.rg.name
    location              = var.location
    size                  = "Standard_D2s_v3"
    admin_username        = var.admin_username
    admin_password        = var.admin_password
    network_interface_ids = \[azurerm_network_interface.nic.id\]

    os_disk {
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }

    source_image_reference {
      publisher = "MicrosoftWindowsServer"
      offer     = "WindowsServer"
      sku       = "2019-Datacenter"
      version   = "latest"
    }
  }

  ```

  8. Create an ouput.tf file

  ```
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
  ```


#### Configure your backend

   Add a backend.tfvars file in the infra folder with the configuration of your azure container.

  ```json
  resource_group_name  = "demo"
  storage_account_name = "abcd1234"
  container_name       = "tfstate"
  key                  = "dev.terraform.tfstate"
  ```

#### Generate your variable file and populate it 

   Generate terraform.tfvars file with the following command and update variables

```bash
  npm run terraform:generate-tfvars
```

   A brand terraform.tfvars file must appear in your infra folder. Its a key value file that looks like this one:

   ```
   admin_password        = ":your very strong password"
   admin_username        = "your admin user name"
   localdate             = "15122022"
   location              = "North Europe"
   location_abbreviation = "northeu"
   resource_name         = "mpe"
   ```
   
   
   Please fill the information

#### Plan your infrastructure

- Plan your terraform deployment

  ```bash
  npm run terraform:plan
  ```

#### Apply your infrastructure

- Apply your terraform deployment

  ```bash
  npm run terraform:apply
  ```

#### Destroy your infrastructure

- Destroy your terraform deployment (for cleanup)

  ```bash
  npm run terraform:destroy
  ```

- Add and Commit your code

  ```bash
  git add .
  npm run commit
  git push
  ```

## Semantic versioning

In order to be able to build automation processes around the versioning we need consistency our git messages management.
\[Commitizen\](https://www.npmjs.com/package/commitizen) will help us use git in a conventinal manner.
To commit your code, you can use the following commands.

```bash
npm run commit
# or
npx cz
```