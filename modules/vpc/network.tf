resource "google_compute_network" "vpc" {
  name                    = "vpc"
  project                 = var.google_cloud_project_id
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "vpc_subnetwork" {
  name          = "vpc-subnetwork"
  ip_cidr_range = "10.2.0.0/20"
  region        = var.google_cloud_region
  network       = google_compute_network.vpc.name
}

resource "google_compute_global_address" "vpc_peering" {
  name          = "vpc-peering"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 20
  network       = google_compute_network.vpc.id
}

resource "google_service_networking_connection" "vpc_connection" {
  network                 = google_compute_network.vpc.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.vpc_peering.name]
}
