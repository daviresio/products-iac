data "google_secret_manager_secret_version" "products_db_password" {
  secret  = var.products_db_password
  version = "latest"
}

locals {
  products_db_password         = data.google_secret_manager_secret_version.products_db_password.secret_data
}
