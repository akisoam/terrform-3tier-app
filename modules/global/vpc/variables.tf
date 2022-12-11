# Define variables
variable "gcp_region" {
  description = "GCP Region"
  type        = string
}

variable "project" {
  description = "Project ID"
  type        = string
}

variable "vpc_name_000" {
  description = "Network name"
  type        = string
}

variable "vpc_description_000" {
  description = "Description of the network"
  type        = string
}

variable "routing_mode" {
  description = "The network routing mode"
  type        = string
  default     = "REGIONAL"
}

variable "auto_create_subnetworks" {
  description = "Set to false"
  type        = bool
  default     = false
}