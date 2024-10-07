module "cloud_run" {
  source                       = "./modules/cloud-run"
  google_cloud_project_id      = var.google_cloud_project_id
  google_cloud_region          = var.google_cloud_region
  cloud_sql_instance_name      = module.sql.cloud_sql_instance_name
  cloud_sql_instance_hostname  = module.sql.cloud_sql_instance_hostname
  vpc_id                       = module.vpc.vpc_id
  vpc_subnetwork_id            = module.vpc.vpc_subnetwork_id
  db_password_id               = module.secret.products_db_password_id
  github_actions_sa_email      = module.service_account.github_actions_sa_email
  cloud_sql_products_db_name   = module.sql.cloud_sql_products_db_name
  cloud_sql_products_user_name = module.sql.cloud_sql_products_user_name

  depends_on = [
    module.secret
  ]
}
