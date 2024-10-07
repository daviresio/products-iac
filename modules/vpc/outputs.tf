output "vpc_id" {
  value = google_compute_network.vpc.id
}

output "vpc_name" {
  value = google_compute_network.vpc.name
}

output "vpc_subnetwork_id" {
  value = google_compute_subnetwork.vpc_subnetwork.id
}

output "public_ip" {
  value = google_compute_global_address.public_ip.address
}
