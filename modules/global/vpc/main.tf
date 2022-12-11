# Google Virtual Private Cloud
resource "google_compute_network" "vpc_000" {
  name                    = var.vpc_name_000
  description             = var.vpc_description_000
  auto_create_subnetworks = var.auto_create_subnetworks
  routing_mode            = var.routing_mode
  project                 = var.project
}
