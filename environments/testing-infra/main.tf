module "vpc" {
  source = "../../modules/vpc"

  project      = var.project
  network_name = local.network_name
  subnetworks  = local.subnetworks
  firewalls    = local.firewalls
}

module "asg" {
  source     = "../../modules/compute"
  depends_on = [module.vpc]

  project      = var.project
  region       = local.region
  vpc_name     = local.network_name
  subnet_name  = "${local.network_name}-${local.region}"
  name         = local.cs_compute_name
  min_replicas = local.min_replicas
  max_replicas = local.max_replicas
}

module "db" {
  source     = "../../modules/database"
  depends_on = [module.vpc]

  region                 = local.region
  database_instance_name = local.cs_db_name
  vpc_id                 = local.network_name
  vpc_self_link          = data.google_compute_network.cs_network.self_link
}
