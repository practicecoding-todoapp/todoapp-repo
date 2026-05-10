


resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = var.nsg_rule_name
    priority                   = var.nsg_rule_priority
    direction                  = var.nsg_rule_direction
    access                     = var.nsg_rule_access
    protocol                   = var.nsg_rule_protocol
    source_port_range          = var.nsg_rule_source_port_range
    destination_port_range     = var.nsg_rule_destination_port_range
    source_address_prefix      = var.nsg_rule_source_address_prefix
    destination_address_prefix = var.nsg_rule_destination_address_prefix
  }
}

