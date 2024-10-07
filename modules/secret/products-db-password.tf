resource "google_secret_manager_secret" "products_db_password" {
  secret_id = "products-db-password"

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "products_db_password_version" {
  secret = google_secret_manager_secret.products_db_password.id

  secret_data = base64decode("cG9zdGdyZXM=")
}