resource "google_compute_subnetwork" "coding_challengesubnetwork2" {
  name                     = var.subnet_coding_challenge2_name
  project                  = var.project
  network                  = var.vpc_uri_000
  description              = var.subnet_coding_challenge2_description
  ip_cidr_range            = var.subnet_coding_challenge2_range
  private_ip_google_access = var.google_api_access
  purpose                  = var.purpose
  role                     = var.role
  depends_on = [
    var.vpc_uri_000,
  ]
}