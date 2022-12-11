# Define outputs of VPC
output "vpc_uri_000" {
  value       = google_compute_network.vpc_000.self_link
  description = "The Self Link of the VPC being created"
}

output "vpc_name_000" {
  value       = google_compute_network.vpc_000.name
  description = "The name of the VPC being created"
}