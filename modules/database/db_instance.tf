locals {
  database_version = var.database_version != null ? var.database_version : "POSTGRES_15"
  database_tier = var.database_tier != null ? var.database_tier : "db-f1-micro"
}

resource "google_compute_global_address" "this" {
  provider = google-beta

  name          = "cs-private-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = var.vpc_id
}

resource "google_service_networking_connection" "this" {
  provider = google-beta

  network                 = var.vpc_id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.this.name]
}

resource "google_sql_database_instance" "this" {
  provider = google-beta

  name             = var.database_instance_name
  region           = var.region
  database_version = local.database_version

  depends_on = [google_service_networking_connection.this]

  settings {
    tier = local.database_tier
    ip_configuration {
      ipv4_enabled                                  = false
      private_network                               = var.vpc_self_link
      enable_private_path_for_google_cloud_services = true
    }
  }
}

