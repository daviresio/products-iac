output "products_api_service_name" {
  value = google_cloud_run_v2_service.products_api.name
}

output "products_web_service_name" {
  value = google_cloud_run_v2_service.products_web.name
}
