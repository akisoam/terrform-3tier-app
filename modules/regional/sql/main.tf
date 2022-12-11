resource "google_sql_database_instance" "postgres" {
    name = var.database_name
    database_version = var.sql_database_version
    deletion_protection = var.delete_protection
  settings{
    tier = var.db_instance_type
  }
}

