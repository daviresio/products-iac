resource "google_compute_global_address" "public_ip" {
  name = "public-ip"

  lifecycle {
    prevent_destroy = true
  }
}
