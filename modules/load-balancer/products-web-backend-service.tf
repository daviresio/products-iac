
resource "google_compute_backend_service" "products_web_backend_service" {
  name     = "products-web-backend-service"
  protocol = "HTTP"

  backend {
    group = google_compute_region_network_endpoint_group.products_web_network_endpoint_group.id
  }
}

resource "google_compute_region_network_endpoint_group" "products_web_network_endpoint_group" {
  name                  = "products-web-network-endpoint-group"
  network_endpoint_type = "SERVERLESS"
  region                = var.google_cloud_region
  cloud_run {
    service = var.products_web_name
  }
}
