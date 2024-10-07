resource "google_compute_managed_ssl_certificate" "products_ssl_cert" {
  name = "products-ssl-cert"

  managed {
    domains = [var.products_domain_name, "www.${var.products_domain_name}"]
  }
}

resource "google_compute_ssl_policy" "products_ssl_policy" {
  name    = "ssl-policy"
  profile = "COMPATIBLE"
}
