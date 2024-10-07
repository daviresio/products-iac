resource "google_cloud_run_v2_service" "products_api" {
  name         = "products-api"
  location     = var.google_cloud_region
  ingress      = "INGRESS_TRAFFIC_INTERNAL_LOAD_BALANCER"
  launch_stage = "BETA"

  # lifecycle {
  #   ignore_changes = [
  #     client_version,
  #     launch_stage,
  #     client,
  #     template[0].labels["commit-sha"],
  #     template[0].labels["managed-by"],
  #     template[0].containers[0].image,
  #   ]
  # }

  template {
    # execution_environment = "EXECUTION_ENVIRONMENT_GEN2"
    service_account = var.github_actions_sa_email

    scaling {
      min_instance_count = 0
      max_instance_count = 2
    }

    volumes {
      name = "cloudsql"
      cloud_sql_instance {
        instances = [var.cloud_sql_instance_name]
      }
    }

    vpc_access {
      egress = "PRIVATE_RANGES_ONLY"

      network_interfaces {
        network    = var.vpc_id
        subnetwork = var.vpc_subnetwork_id
      }
    }

    containers {
      image = "us-east1-docker.pkg.dev/products-437516/products-repository/products-api:latest"

      ports {
        container_port = 8080
      }

      startup_probe {
        initial_delay_seconds = 0
        timeout_seconds       = 5
        period_seconds        = 5
        failure_threshold     = 5
        http_get {
          path = "/api/health"
          port = 8080
        }
      }

      env {
        name  = "DB_HOST"
        value = var.cloud_sql_instance_hostname
      }

      env {
        name  = "DB_PORT"
        value = "5432"
      }

      env {
        name  = "DB_USER"
        value = var.cloud_sql_products_user_name
      }

      env {
        name = "DB_PASSWORD"
        value_source {
          secret_key_ref {
            secret  = "products-db-password"
            version = "latest"
          }
        }
      }

      env {
        name  = "DB_NAME"
        value = var.cloud_sql_products_db_name
      }

      resources {
        limits = {
          cpu    = "0.5"
          memory = "256Mi"
        }
        startup_cpu_boost = "true"
        cpu_idle          = "true"
      }

      volume_mounts {
        name       = "cloudsql"
        mount_path = "/cloudsql"
      }
    }

  }
}
resource "google_cloud_run_v2_service_iam_member" "products_api_unauthenticated_access" {
  location = var.google_cloud_region
  name     = google_cloud_run_v2_service.products_api.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}

resource "google_cloud_run_v2_service_iam_member" "github_actions_sa_cloud_run_products_api" {
  location = var.google_cloud_region
  name     = google_cloud_run_v2_service.products_api.name
  role     = "roles/run.admin"
  member   = "serviceAccount:${var.github_actions_sa_email}"
}
