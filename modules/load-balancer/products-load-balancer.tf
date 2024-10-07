resource "google_compute_url_map" "load_balancer_url_map" {
  name            = "load-balancer-url-map"
  default_service = google_compute_backend_service.products_web_backend_service.id

  host_rule {
    hosts        = ["www.${var.products_domain_name}", var.products_domain_name]
    path_matcher = "productspaths"
  }

  path_matcher {
    name            = "productspaths"
    default_service = google_compute_backend_service.products_web_backend_service.id

    path_rule {
      paths   = ["/api/*"]
      service = google_compute_backend_service.products_api_backend_service.id
    }
  }
}

resource "google_compute_target_http_proxy" "load_balancer_http_proxy" {
  name    = "load-balancer-http-proxy"
  url_map = google_compute_url_map.load_balancer_url_map.id
}

resource "google_compute_global_forwarding_rule" "http_forwarding_rule" {
  name       = "http-forwarding-rule"
  target     = google_compute_target_http_proxy.load_balancer_http_proxy.id
  port_range = "80"
  ip_address = var.public_ip
}

resource "google_compute_target_https_proxy" "load_balancer_https_proxy" {
  name             = "load-balancer-https-proxy"
  url_map          = google_compute_url_map.load_balancer_url_map.id
  ssl_certificates = [var.ssl_certificate_id]
  ssl_policy       = var.ssl_policy_id
}

resource "google_compute_global_forwarding_rule" "https_forwarding_rule" {
  name       = "https-forwarding-rule"
  target     = google_compute_target_https_proxy.load_balancer_https_proxy.id
  port_range = "443"
  ip_address = var.public_ip
}
