module "service_account" {
  source                             = "./modules/service-account"
  google_cloud_project_id            = var.google_cloud_project_id
  github_org_name                    = var.github_org_name
  github_workload_identity_pool_name = module.oidc.github_workload_identity_pool_name
}
