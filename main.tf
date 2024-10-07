terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.16.0"
    }
  }

  cloud {
    organization = "products"
    workspaces {
      name = "products-workspace"
    }
  }
}

provider "google" {
  project = var.google_cloud_project_id
  region  = var.google_cloud_region
  zone    = var.google_cloud_zone
}
