# Define outputs

output "proxy_subnetwork_uri" {
  value       = google_compute_subnetwork.coding_challengesubnetwork2.self_link
  description = "coding challenge Subnetwork 2 URI"
}