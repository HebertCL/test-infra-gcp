locals {
  machine_type = var.machine_type != null ? var.machine_type : "e2-micro"
  source_image = var.source_image != null ? var.source_image : "debian-cloud/debian-11"
  disk_size_gb = var.disk_size_gb != null ? var.disk_size_gb : 10
  disk_type = var.disk_type != null ? var.disk_type : "pd-standard"

  labels = var.labels != null ? var.labels : {"created_by" = "terraform"}
}

resource "google_compute_instance_template" "this" {
  name         = "${var.name}-template-${formatdate("YYYYMMDD-hhmm", timestamp())}"
  machine_type = local.machine_type
  region       = var.region

  disk {
    source_image = local.source_image
    auto_delete  = true
    boot         = true
    disk_size_gb = local.disk_size_gb
    disk_type    = local.disk_type
  }

  network_interface {
    network    = var.vpc_name
    subnetwork = var.subnet_name
    
    access_config {
      network_tier = "PREMIUM"
    }
  }

  service_account {
    email = google_service_account.this.email
    scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }

  tags = ["http-server", "health-check"]

  labels = local.labels

  #metadata_startup_script = templatefile("${path.module}/startup-script.sh", {
  #  app_name = var.app_name
  #})

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_service_account" "this" {
  account_id   = "${var.name}-sa"
  display_name = "${var.name} Service Account"
  description  = "Service account for ${var.name} application"
}

resource "google_project_iam_member" "this" {
  for_each = toset(local.iam_members)

  project = var.project
  role    = each.value
  member  = "serviceAccount:${google_service_account.this.email}"
}

