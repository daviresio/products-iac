resource "google_compute_backend_service" "products_api_backend_service" {
  name = "products-api-backend-service"

  backend {
    group = google_compute_region_network_endpoint_group.products_api_network_endpoint_group.id
  }
}

resource "google_compute_region_network_endpoint_group" "products_api_network_endpoint_group" {
  name                  = "products-api-network-endpoint-group"
  network_endpoint_type = "SERVERLESS"
  region                = var.google_cloud_region
  cloud_run {
    service = var.products_api_name
  }
}
