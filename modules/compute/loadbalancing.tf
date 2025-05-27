locals {
  lb_protocol = var.lb_protocol != null ? var.lb_protocol : "HTTP"
  lb_scheme = var.lb_scheme != null ? var.lb_scheme : "EXTERNAL"
  lb_timeout = var.lb_timeout != null ? var.lb_timeout : 30

  iam_members = [
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter",
  ]
}

resource "google_compute_backend_service" "this" {
  name                  = "${var.name}-backend"
  protocol              = local.lb_protocol
  port_name             = "http"
  load_balancing_scheme = local.lb_scheme
  timeout_sec           = local.lb_timeout

  backend {
    group           = google_compute_region_instance_group_manager.this.instance_group
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 1.0
  }

  health_checks = [google_compute_health_check.this.id]
}

resource "google_compute_url_map" "this" {
  name            = "${var.name}-url-map"
  default_service = google_compute_backend_service.this.id
}

resource "google_compute_target_http_proxy" "this" {
  name    = "${var.name}-proxy"
  url_map = google_compute_url_map.this.id
}

resource "google_compute_global_forwarding_rule" "this" {
  name       = "${var.name}-forwarding-rule"
  target     = google_compute_target_http_proxy.this.id
  port_range = "80"
}

