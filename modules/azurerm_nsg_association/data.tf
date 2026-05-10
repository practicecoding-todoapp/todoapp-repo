data "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.resource_group_name
}

data "azurerm_network_security_group" "nsg_id" {
  name                = var.nsg_name
  resource_group_name = var.resource_group_name
}