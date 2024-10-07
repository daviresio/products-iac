output "ssl_certificate_id" {
  value = google_compute_managed_ssl_certificate.products_ssl_cert.id
}

output "ssl_policy_id" {
  value = google_compute_ssl_policy.products_ssl_policy.id
}
