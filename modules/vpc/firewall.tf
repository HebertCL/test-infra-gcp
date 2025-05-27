resource "google_compute_firewall" "this" {
  for_each = var.firewalls

  name = "${google_compute_network.this.name}-${each.key}"
  network = google_compute_network.this.name
  source_ranges = each.value.source_ranges
  target_tags = each.value.target_tags

  allow {
    protocol = each.value.protocol
    ports = each.value.ports
  } 
}

