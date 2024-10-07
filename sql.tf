module "sql" {
  source                  = "./modules/sql"
  google_cloud_project_id = var.google_cloud_project_id
  google_cloud_region     = var.google_cloud_region
  vpc_id              = module.vpc.vpc_id
  products_db_password = module.secret.products_db_password_id
  cloud_sql_products_db_name = module.sql.cloud_sql_products_db_name

  depends_on = [
    module.vpc
  ]
}