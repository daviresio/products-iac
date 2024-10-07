resource "google_service_account" "github_actions_sa" {
  project      = var.google_cloud_project_id
  account_id   = "github-actions"
  display_name = "Service Account used for GitHub Actions"
}

resource "google_service_account_iam_member" "github_actions_sa_workload_identity_user" {
  service_account_id = google_service_account.github_actions_sa.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${var.github_workload_identity_pool_name}/attribute.repository_owner/${var.github_org_name}"
}

resource "google_service_account_iam_member" "github_actions_sa_service_account_user" {
  service_account_id = google_service_account.github_actions_sa.name
  role               = "roles/iam.serviceAccountUser"
  member             = "serviceAccount:${google_service_account.github_actions_sa.email}"
}

resource "google_project_iam_member" "github_actions_sa_artifact_registry_admin" {
  project = var.google_cloud_project_id
  role    = "roles/artifactregistry.admin"
  member  = "serviceAccount:${google_service_account.github_actions_sa.email}"
}

resource "google_project_iam_member" "github_actions_sa_cloud_run_admin" {
  project = var.google_cloud_project_id
  role    = "roles/run.admin"
  member  = "serviceAccount:${google_service_account.github_actions_sa.email}"
}

resource "google_project_iam_member" "github_actions_sa_secret_admin" {
  project = var.google_cloud_project_id
  role    = "roles/secretmanager.admin"
  member  = "serviceAccount:${google_service_account.github_actions_sa.email}"
}

resource "google_project_iam_member" "github_actions_sa_metrics_writer" {
  project = var.google_cloud_project_id
  role    = "roles/monitoring.metricWriter"
  member  = "serviceAccount:${google_service_account.github_actions_sa.email}"
}

resource "google_project_iam_member" "github_actions_sa_cloud_trace_admin" {
  project = var.google_cloud_project_id
  role    = "roles/cloudtrace.admin"
  member  = "serviceAccount:${google_service_account.github_actions_sa.email}"
}

resource "google_project_iam_member" "github_actions_sa_logging_admin" {
  project = var.google_cloud_project_id
  role    = "roles/logging.admin"
  member  = "serviceAccount:${google_service_account.github_actions_sa.email}"
}

resource "google_project_iam_member" "github_actions_sa_stackdriver_writer" {
  project = var.google_cloud_project_id
  role    = "roles/stackdriver.resourceMetadata.writer"
  member  = "serviceAccount:${google_service_account.github_actions_sa.email}"
}
