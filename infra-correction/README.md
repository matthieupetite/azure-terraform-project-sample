# Main title

Everything in this comment block will get extracted.

You can put simple text or complete Markdown content
here. Subsequently if you want to render AsciiDoc format
you can put AsciiDoc compatible content in this comment
block.
Start implementing your terraform code here 😎

## Requirements

| Name                                                                  | Version |
| --------------------------------------------------------------------- | ------- |
| <a name="requirement_azurecaf"></a> [azurecaf](#requirement_azurecaf) | =1.2.1  |

## Providers

| Name                                                            | Version |
| --------------------------------------------------------------- | ------- |
| <a name="provider_azurecaf"></a> [azurecaf](#provider_azurecaf) | 1.2.1   |
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm)    | 3.35.0  |

## Modules

No modules.

## Resources

| Name                                                                                                                          | Type     |
| ----------------------------------------------------------------------------------------------------------------------------- | -------- |
| [azurecaf_name.rg](https://registry.terraform.io/providers/aztfmod/azurecaf/1.2.1/docs/resources/name)                        | resource |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

| Name                                                                                             | Description                            | Type     | Default          | Required |
| ------------------------------------------------------------------------------------------------ | -------------------------------------- | -------- | ---------------- | :------: |
| <a name="input_localdate"></a> [localdate](#input_localdate)                                     | Local Date                             | `string` | `"15122022"`     |    no    |
| <a name="input_location"></a> [location](#input_location)                                        | Location of the resources              | `string` | `"North Europe"` |    no    |
| <a name="input_location_abbreviation"></a> [location_abbreviation](#input_location_abbreviation) | Location abbreviation of the resources | `string` | `"northeu"`      |    no    |

## Outputs

| Name                                                                 | Description                                       |
| -------------------------------------------------------------------- | ------------------------------------------------- |
| <a name="output_rg_location"></a> [rg_location](#output_rg_location) | This is the output of the resource group location |
| <a name="output_rg_name"></a> [rg_name](#output_rg_name)             | This is the output of the resource group name     |
