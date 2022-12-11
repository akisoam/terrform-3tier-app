# Define application Subnetwork
resource "google_compute_subnetwork" "coding_challengesubnetwork" {
  name                     = var.subnet_coding_challenge_name
  project                  = var.project
  network                  = var.vpc_uri_000
  description              = var.subnet_coding_challenge_description
  ip_cidr_range            = var.subnet_coding_challenge_range
  private_ip_google_access = var.google_api_access
  log_config {
    aggregation_interval = var.flow_log_aggregation_interval
    flow_sampling        = var.flow_log_sampling_rate
    metadata             = var.flow_log_metadata
  }
  depends_on = [
    var.vpc_uri_000,
  ]
}