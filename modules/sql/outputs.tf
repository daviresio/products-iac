output "cloud_sql_instance_name" {
  value = google_sql_database_instance.products_db_instance.connection_name
}

output "cloud_sql_instance_hostname" {
  value = google_sql_database_instance.products_db_instance.private_ip_address
}

output "cloud_sql_products_db_name" {
  value = google_sql_database.products_db.name
}


output "cloud_sql_products_user_name" {
  value = google_sql_user.database_user.name
}
