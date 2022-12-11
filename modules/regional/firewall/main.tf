# Define firewall modules

/* resource "google_compute_firewall" "default" {
  name = "fw-allow-health-check"
  allow {
    protocol = "tcp"
  }
  direction     = "INGRESS"
  network       = module.vpc.vpc_uri_000
  priority      = 1000
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
  target_tags   = ["load-balanced-backend"]
} */

resource "google_compute_firewall" "default" {
  name = var.firewall_name
  allow {
    protocol = var.protocol
  }
  direction     = var.direction
  #network       = module.vpc.vpc_uri_000
  network       = var.vpc_uri_000
  priority      = 1000
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
  target_tags   = ["load-balanced-backend"]
}