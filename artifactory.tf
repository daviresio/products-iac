module "artifactory" {
  source                  = "./modules/artifactory"
  google_cloud_project_id = var.google_cloud_project_id
  google_cloud_region     = var.google_cloud_region
}
