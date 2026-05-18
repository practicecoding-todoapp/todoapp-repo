module "resource_group" {
  source                  = "../modules/azurerm_resource_group"
  resource_group_name     = "todoapp-rg"
  resource_group_location = "centralindia"
}



module "resource_group3" {
  source                  = "../modules/azurerm_resource_group"
  resource_group_name     = "todoapp-rg3"
  resource_group_location = "canadacentral"
}

module "resource_group1" {
  source                  = "../modules/azurerm_resource_group"
  resource_group_name     = "todoapp-rg1"
  resource_group_location = "centralindia"

}

module "resource_group2" {
  source                  = "../modules/azurerm_resource_group"
  resource_group_name     = "rg-Australia"
  resource_group_location = "centralindia"

}
module "virtual_network" {
  depends_on               = [module.resource_group]
  source                   = "../modules/azurerm_virtual_network"
  virtual_network_name     = "todoapp-vnet"
  virtual_network_location = "centralindia"
  resource_group_name      = "todoapp-rg"
  address_space            = ["10.0.0.0/16"]
}

module "frontend_subnet" {
  depends_on           = [module.virtual_network]
  source               = "../modules/azurerm_subnet"
  subnet_name          = "frontend-subnet"
  resource_group_name  = "todoapp-rg"
  virtual_network_name = "todoapp-vnet"
  address_prefixes     = ["10.0.1.0/24"]
}

module "frontend_suresh" {
  depends_on           = [module.virtual_network]
  source               = "../modules/azurerm_subnet"
  subnet_name          = "frontend-suresh"
  resource_group_name  = "suresh-rg"
  virtual_network_name = "suresh-vnet"
  address_prefixes     = ["10.0.1.0/24"]
}
module "frontend_rakesh" {
  depends_on           = [module.virtual_network]
  source               = "../modules/azurerm_subnet"
  subnet_name          = "frontend-rakesh"
  resource_group_name  = "trakesh-rg"
  virtual_network_name = "rakesh-vnet"
  address_prefixes     = ["10.0.7.0/24"]
}

module "backend_subnet" {
  depends_on           = [module.virtual_network]
  source               = "../modules/azurerm_subnet"
  subnet_name          = "backend-subnet"
  resource_group_name  = "todoapp-rg"
  virtual_network_name = "todoapp-vnet"
  address_prefixes     = ["10.0.2.0/24"]
}


module "frontend_pip" {
  depends_on          = [module.resource_group]
  source              = "../modules/azurerm_public_ip"
  public_ip_name      = "frontend-pip"
  resource_group_name = "todoapp-rg"
  location            = "centralindia"
  allocation_method   = "Static"
}

module "backend_pip" {
  depends_on          = [module.resource_group]
  source              = "../modules/azurerm_public_ip"
  public_ip_name      = "backend-pip"
  resource_group_name = "todoapp-rg"
  location            = "centralindia"
  allocation_method   = "Static"
}


module "frontend_nsg" {
  depends_on                          = [module.resource_group]
  source                              = "../modules/azurerm_nsg"
  nsg_name                            = "frontend-nsg"
  location                            = "centralindia"
  resource_group_name                 = "todoapp-rg"
  nsg_rule_name                       = "Allow-HTTP-Inbound"
  nsg_rule_priority                   = 100
  nsg_rule_direction                  = "Inbound"
  nsg_rule_access                     = "Allow"
  nsg_rule_protocol                   = "Tcp"
  nsg_rule_source_port_range          = "*"
  nsg_rule_destination_port_range     = "80"
  nsg_rule_source_address_prefix      = "*"
  nsg_rule_destination_address_prefix = "*"
}

module "backend_nsg" {
  depends_on                          = [module.resource_group]
  source                              = "../modules/azurerm_nsg"
  nsg_name                            = "backend-nsg"
  location                            = "centralindia"
  resource_group_name                 = "todoapp-rg"
  nsg_rule_name                       = "Allow-SSH-Inbound"
  nsg_rule_priority                   = 100
  nsg_rule_direction                  = "Inbound"
  nsg_rule_access                     = "Allow"
  nsg_rule_protocol                   = "Tcp"
  nsg_rule_source_port_range          = "*"
  nsg_rule_destination_port_range     = "22"
  nsg_rule_source_address_prefix      = "*"
  nsg_rule_destination_address_prefix = "*"
}


module "frontend_nsg_association" {
  depends_on           = [module.frontend_nsg, module.frontend_subnet]
  source               = "../modules/azurerm_nsg_association"
  subnet_name          = "frontend-subnet"
  virtual_network_name = "todoapp-vnet"
  resource_group_name  = "todoapp-rg"
  nsg_name             = "frontend-nsg"
}

module "backend_nsg_association" {
  depends_on           = [module.backend_nsg, module.backend_subnet]
  source               = "../modules/azurerm_nsg_association"
  subnet_name          = "backend-subnet"
  virtual_network_name = "todoapp-vnet"
  resource_group_name  = "todoapp-rg"
  nsg_name             = "backend-nsg"
}

module "sql_server" {
  depends_on                   = [module.resource_group]
  source                       = "../modules/azurerm_sql_server"
  sql_server_name              = "todoapp-sql-server"
  resource_group_name          = "todoapp-rg"
  location                     = "centralindia"
  administrator_login          = "sqladmin"
  administrator_login_password = "P@ssw0rd1234"
}

module "sql_database" {
  depends_on          = [module.sql_server]
  source              = "../modules/azurerm_sql_database"
  sql_database_name   = "todoappdb"
  sql_server_name     = "todoapp-sql-server"
  resource_group_name = "todoapp-rg"
}

module "frontend_vm" {
  depends_on           = [module.frontend_subnet, module.key_vault, module.key_vault_Username, module.key_vault_Password]
  source               = "../modules/azurerm_virtual_machine"
  vm_name              = "frontend-vm"
  location             = "centralindia"
  resource_group_name  = "todoapp-rg"
  vm_size              = "Standard_B1s"
  admin_username       = "azureuser"
  admin_password       = "P@ssw0rd1234"
  image_publisher      = "Canonical"
  image_offer          = "UbuntuServer"
  image_sku            = "18.04-LTS"
  image_version        = "latest"
  virtual_network_name = "todoapp-vnet"
  subnet_name          = "frontend-subnet"
  pip_name             = "frontend-pip"
  nic_name             = "frontend-nic"
}

module "backend_vm" {
  depends_on           = [module.backend_subnet, module.key_vault, module.key_vault_Username, module.key_vault_Password]
  source               = "../modules/azurerm_virtual_machine"
  vm_name              = "backend-vm"
  location             = "centralindia"
  resource_group_name  = "todoapp-rg"
  vm_size              = "Standard_B1s"
  admin_username       = "azureuser"
  admin_password       = "P@ssw0rd1234"
  image_publisher      = "Canonical"
  image_offer          = "UbuntuServer"
  image_sku            = "18.04-LTS"
  image_version        = "latest"
  virtual_network_name = "todoapp-vnet"
  subnet_name          = "backend-subnet"
  pip_name             = "backend-pip"
  nic_name             = "backend-nic"
}


module "key_vault" {
  depends_on          = [module.resource_group]
  source              = "../modules/azurerm_keyvault"
  key_vault_name      = "mazdadb-kv"
  location            = "centralindia"
  resource_group_name = "todoapp-rg"
}

module "key_vault_Username" {
  depends_on          = [module.key_vault]
  source              = "../modules/azurerm_keyvault_secret"
  secret_name         = "Username"
  secret_value        = "DevopsAdmin"
  key_vault_name      = "mazdadb-kv"
  resource_group_name = "todoapp-rg"
}

module "key_vault_Password" {
  depends_on          = [module.key_vault]
  source              = "../modules/azurerm_keyvault_secret"
  secret_name         = "Password"
  secret_value        = "P@a$$Word1234"
  key_vault_name      = "mazdadb-kv"
  resource_group_name = "todoapp-rg"
}