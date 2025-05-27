locals {
  region       = "us-west1"
  network_name = "cs-network"

  subnetworks = {
    "us-west1" = {
      ip_cidr_range = "10.1.0.0/24"
      region        = "us-west1"
    }
    "us-west2" = {
      ip_cidr_range = "10.2.0.0/24"
      region        = "us-west2"
    }
  }

  firewalls = {
    "allow-http" = {
      source_ranges = ["0.0.0.0/0"]
      target_tags   = ["allow-http"]
      protocol      = "tcp"
      ports         = ["80", "8080"]
    }
    "allow-http-healthcheck" = {
      source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
      target_tags   = ["health-check"]
      protocol      = "tcp"
      ports         = ["80", "8080"]
    }
  }

  cs_compute_name = "cs-compute"
  min_replicas    = 1
  max_replicas    = 2

  cs_db_name = "cs-db"
}
