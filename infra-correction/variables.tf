
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
    type    = string
    default = "default_admin_password"
    sensitive = true
}

variable "admin_username" {
    type    = string
    default = "default_admin_username"
}