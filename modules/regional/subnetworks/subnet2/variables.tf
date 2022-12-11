
# Define variables
variable "project" {
    type = string
    description = "GCP Project ID"
  
}

variable "vpc_uri_000" {
    type = string
    description = "VPC URI"
  
}

variable "google_api_access" {
    type = bool
    description = "When enabled, VMs in this subnetwork without external IP addresses can access Google APIs and services by using Private Google Access."
  
}

variable "flow_log_aggregation_interval" {
    type = string
    description = "The aggregation interval for collecting flow logs."
  
}

variable "flow_log_sampling_rate" {
    type = number
    description = "The sampling rate of VPC flow logs"
  
}

variable "flow_log_metadata" {
    type = string
    description = "Configures whether metadata fields should be added to the reported VPC flow logs"
  
}


variable "subnet_coding_challenge2_name" {
    type = string
    description = "VPC coding challenge application subnetwork name"
  
}

variable "subnet_coding_challenge2_description" {
    type = string
    description = "coding challenge application Subnetwork Description"
  
}

variable "subnet_coding_challenge2_range" {
    type = string
    description = "VPC coding challenge application subnetwork range"
}

variable "purpose" {
    type = string
    description = "purpose of the subnet"
  
}

variable "role" {
    type = string
    description = "role of the subnet"
  
}




