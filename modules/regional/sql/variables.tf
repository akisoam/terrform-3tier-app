#define Variables
variable "database_name" {
type = string
description = "Database name"
}

variable "sql_database_version" {
    type = string
    description = "Cloud sql database version"
  
}

variable "db_instance_type" {
    type = string
    description = "instance type"
  
}

variable "delete_protection" {
    type = bool
    default = false
    description = "Whether or not to allow Terraform to destroy the instance."
  
}
