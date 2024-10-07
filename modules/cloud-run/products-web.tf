
resource "google_cloud_run_v2_service" "products_web" {
  name     = "products-web"
  location = var.google_cloud_region
  ingress  = "INGRESS_TRAFFIC_ALL"

  template {
    service_account = var.github_actions_sa_email

    scaling {
      min_instance_count = 0
      max_instance_count = 2
    }

    containers {
      image = "us-east1-docker.pkg.dev/products-437516/products-repository/products-web:latest"
      resources {
        limits = {
          cpu    = "1"
          memory = "512Mi"
        }
        startup_cpu_boost = true
        cpu_idle          = true
      }
      ports {
        container_port = 3000
      }
    }
  }

  traffic {
    type    = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
    percent = 100
  }
}

resource "google_cloud_run_v2_service_iam_member" "products_web_unauthenticated_access" {
  location = var.google_cloud_region
  name     = google_cloud_run_v2_service.products_web.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}

resource "google_cloud_run_v2_service_iam_member" "github_actions_sa_cloud_run_products_web" {
  location = var.google_cloud_region
  name     = google_cloud_run_v2_service.products_web.name
  role     = "roles/run.admin"
  member   = "serviceAccount:${var.github_actions_sa_email}"
}
