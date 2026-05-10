

variable "vm_name" {
  description = "name of virtual machine"
  type = string
}

variable "location" {
  description = "location of virtual machine"
  type = string
}

variable "resource_group_name" {
  description = "name of the resource group"
  type = string
}



variable "vm_size" {
  description = "size of the virtual machine"
  type = string
}

variable "admin_username" {
  description = "admin username for virtual machine"
  type = string
}

variable "admin_password" {
  description = "admin password for virtual machine"
  type = string
}

variable "image_publisher" {
  description = "publisher of the image"
  type = string
}

variable "image_offer" {
  description = "offer of the image"
  type = string
}

variable "image_sku" {
  description = "sku of the image"
  type = string
}

variable "image_version" {
  description = "version of the image"
  type = string
}


variable "virtual_network_name" {
  description = "name of virtual network"
  type = string
}

variable "subnet_name" {
  description = "name of subnet"
  type = string
}




variable "pip_name" {
  description = "name of public ip"
  type = string
  
}



variable  "nic_name" {
  description = "name of network interface"
  type = string
}