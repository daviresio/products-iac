
resource "google_sql_database_instance" "products_db_instance" {
  name             = "products-db"
  region           = var.google_cloud_region
  database_version = "POSTGRES_15"

  lifecycle {
    ignore_changes = [
      settings[0].ip_configuration[0].authorized_networks,
    ]
  }

  settings {
    tier            = "db-g1-small"
    disk_type       = "PD_SSD"
    disk_size       = 10
    disk_autoresize = "true"
    edition         = "ENTERPRISE"

    ip_configuration {
      ipv4_enabled                                  = "true"
      enable_private_path_for_google_cloud_services = "true"
      private_network                               = var.vpc_id
    }
  }

  deletion_protection = "true"
}


resource "google_sql_database" "products_db" {
  name            = "products-db"
  instance        = google_sql_database_instance.products_db_instance.name
  deletion_policy = "DELETE"
}

resource "google_sql_user" "database_user" {
  name     = "database-user"
  instance = google_sql_database_instance.products_db_instance.name
  password = local.products_db_password
}
