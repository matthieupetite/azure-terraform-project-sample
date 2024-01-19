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
