variable "public_ip_name" {
  type = string
    description = "The name of the public IP address."
}

variable "resource_group_name" {
  type = string
    description = "The name of the resource group in which to create the public IP address."
}

variable "location" {
  type = string
    description = "The location/region where the public IP address should be created."
}

variable "allocation_method" {
  type = string
description = "The allocation method for the public IP address. Possible values are 'Static' or 'Dynamic'."

}

