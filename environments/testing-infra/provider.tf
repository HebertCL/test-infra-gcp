provider "google" {
  project = var.project
  region  = local.region
}

provider "google-beta" {
  project = var.project
  region  = local.region
}
