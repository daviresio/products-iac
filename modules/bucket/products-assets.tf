resource "google_storage_bucket" "products_assets" {
  force_destroy = false

  location                    = var.google_cloud_region
  name                        = "daviresio-products-assets"
  project                     = var.google_cloud_project_id
  uniform_bucket_level_access = true

  cors {
    origin          = ["*"]
    method          = ["GET"]
    response_header = ["*"]
    max_age_seconds = 3600
  }
}

resource "google_storage_bucket_iam_binding" "products_assets_public_access" {
  bucket = google_storage_bucket.products_assets.name

  role    = "roles/storage.objectViewer"
  members = ["allUsers"]
}
