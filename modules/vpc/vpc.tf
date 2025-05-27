locals {
  routing_mode = var.routing_mode != null ? var.routing_mode : "GLOBAL"
  auto_create_subnetworks = var.auto_create_subnetworks != null ? var.auto_create_subnetworks : false 
}

resource "google_compute_network" "this" {
  project                                   = var.project
  name                                      = var.network_name
  routing_mode                              = local.routing_mode
  auto_create_subnetworks = local.auto_create_subnetworks
}

resource "google_compute_subnetwork" "this" {
  for_each = var.subnetworks
  
  name          = "${google_compute_network.this.name}-${each.key}"
  ip_cidr_range = each.value.ip_cidr_range
  region        = each.value.region
  network       = google_compute_network.this.id
}
