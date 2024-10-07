resource "google_artifact_registry_repository" "products_repository" {
    project = var.google_cloud_project_id
    location = var.google_cloud_region
    repository_id = "products-repository"
    format = "DOCKER"
}