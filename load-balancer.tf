module "load_balancer" {
  source                  = "./modules/load-balancer"
  google_cloud_region     = var.google_cloud_region
  ssl_certificate_id      = module.certificate.ssl_certificate_id
  public_ip               = module.vpc.public_ip
  products_api_name       = module.cloud_run.products_api_service_name
  products_web_name       = module.cloud_run.products_web_service_name
  products_domain_name    = var.products_domain_name
  github_actions_sa_email = module.service_account.github_actions_sa_email
  ssl_policy_id           = module.certificate.ssl_policy_id

  depends_on = [
    module.certificate
  ]

}

