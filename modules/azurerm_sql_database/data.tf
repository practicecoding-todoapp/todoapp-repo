data "azurerm_mssql_server" "sql_server_id" {
  name                = var.sql_server_name
  resource_group_name = var.resource_group_name
  
}