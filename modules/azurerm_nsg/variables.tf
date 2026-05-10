variable "nsg_name" {
  description = "name of network security group"
  type        = string
}

variable "location" {
  description = "location of network security group"
  type        = string
}

variable "resource_group_name" {
  description = "name of the resource group"
  type        = string
}

variable "nsg_rule_name" {
  description = "name of the NSG rule"
  type        = string
}

variable "nsg_rule_priority" {
  description = "priority of the NSG rule"
  type        = number
}

variable "nsg_rule_direction" {
  description = "direction of the NSG rule"
  type        = string
}

variable "nsg_rule_access" {
  description = "access of the NSG rule"
  type        = string
}

variable "nsg_rule_protocol" {
  description = "protocol of the NSG rule"
  type        = string
}

variable "nsg_rule_source_port_range" {
  description = "source port range of the NSG rule"
  type        = string
}

variable "nsg_rule_destination_port_range" {
  description = "destination port range of the NSG rule"
  type        = string
}

variable "nsg_rule_source_address_prefix" {
  description = "source address prefix of the NSG rule"
  type        = string
}

variable "nsg_rule_destination_address_prefix" {
  description = "destination address prefix of the NSG rule"
  type        = string
}