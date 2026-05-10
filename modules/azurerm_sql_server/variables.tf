variable "sql_server_name" {
    description = "The name of the SQL Server."
    type        = string
}
variable "resource_group_name" {
    description = "The name of the resource group in which to create the SQL Server."
    type        = string
}
variable "location" {
    description = "The location of the SQL Server."
    type        = string
}
variable "administrator_login" {
    description = "The login for the SQL Server administrator."
    type        = string
}
variable "administrator_login_password" {
    description = "The password for the SQL Server administrator."
    type        = string
    sensitive = true
}