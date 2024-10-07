module "certificate" {
  source           = "./modules/certificate"
  products_domain_name  = var.products_domain_name
} 