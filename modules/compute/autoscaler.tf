locals {
  health_check_port = var.health_check_port != null ? var.health_check_port : "8080"
  health_check_path = var.health_check_path != null ? var.health_check_path : "/health"
  health_check_interval = var.health_check_interval != null ? var.health_check_interval : 30
  health_check_treshhold = 3
  cooldown_period = var.cooldown_period != null ? var.cooldown_period : 60
  cpu_utilization = var.cpu_utilization != null ? var.cpu_utilization : 0.7
}

resource "google_compute_health_check" "this" {
  name                = "${var.name}-health-check"
  check_interval_sec  = local.health_check_interval
  healthy_threshold   = local.health_check_treshhold
  unhealthy_threshold = local.health_check_treshhold

  http_health_check {
    port               = local.health_check_port
    request_path       = local.health_check_path
  }
}

resource "google_compute_region_instance_group_manager" "this" {
  name   = "${var.name}-group"
  region = var.region

  base_instance_name = var.name

  version {
    instance_template = google_compute_instance_template.this.id
  }

  auto_healing_policies {
    health_check      = google_compute_health_check.this.id
    initial_delay_sec = 300
  }

  update_policy {
    type                           = "PROACTIVE"
    minimal_action                 = "REPLACE"
    replacement_method             = "SUBSTITUTE"
    max_surge_fixed                = 3
    max_unavailable_fixed          = 0
  }

  named_port {
    name = "http"
    port = local.health_check_port
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_region_autoscaler" "this" {
  name   = "${var.name}-autoscaler"
  region = var.region
  target = google_compute_region_instance_group_manager.this.id

  autoscaling_policy {
    max_replicas    = var.max_replicas
    min_replicas    = var.min_replicas
    cooldown_period = local.cooldown_period

    cpu_utilization {
      target = local.cpu_utilization
    }
  }
}
