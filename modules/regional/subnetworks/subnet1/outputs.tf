# Define outputs
output "app_subnetwork_uri" {
  value       = google_compute_subnetwork.coding_challengesubnetwork.self_link
  description = "coding challenge Subnetwork 1 URI"
}