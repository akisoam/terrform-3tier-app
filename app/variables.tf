########################################################################
# Define variables to be used for all GCP Resources
########################################################################

variable "gcp_region" {
  type        = string
  default = "us-west1"
}

variable "project" {
  type        = string
}

variable "gcp_ukl_zone_a" {
  type = string
  default = "us-west1-a"
}

variable "gcp_ukl_zone_b" {
  type = string
  default = "us-west1-b"
}

########################################################################
# Define variables to be used for VPC resources to be added to VPC
########################################################################

variable "vpc_name_000" {
  type        = string
  description = "VPC Name"
}

variable "vpc_description_000" {
  type        = string
  description = "VPC Description"
}

variable "routing_mode" {
  description = "The network routing mode (default 'GLOBAL')"
  type        = string
  default     = "GLOBAL"
}

variable "auto_create_subnetworks" {
  description = "When set to true, the network is created in 'auto subnet mode' and it will create a subnet for each region automatically across the 10.128.0.0/9 address range. When set to false, the network is created in 'custom subnet mode' so the user can explicitly connect subnetwork resources."
  type        = bool
  default     = false
}

########################################################################
# Define variables to be used for Subnetwork
########################################################################

variable "subnet_coding_challenge_name" {
  type        = string
}

variable "subnet_coding_challenge_description" {
  type        = string
}

variable "subnet_coding_challenge_range" {
  type        = string
}

variable "subnet_coding_challenge2_name" {
  type        = string
}

variable "subnet_coding_challenge2_description" {
  type        = string
}

variable "subnet_coding_challenge2_range" {
  type        = string
}


variable "flow_log_aggregation_interval" {
  description = "The aggregation interval for collecting flow logs."
  type        = string
  default     = "INTERVAL_10_MIN"
}

variable "flow_log_sampling_rate" {
  description = "The sampling rate of VPC flow logs"
  type        = number
  default     = 0.5
}

variable "flow_log_metadata" {
  description = "Configures whether metadata fields should be added to the reported VPC flow logs"
  type        = string
  default     = "INCLUDE_ALL_METADATA"
}

variable "google_api_access" {
  description = "When enabled, VMs in this subnetwork without external IP addresses can access Google APIs and services by using Private Google Access."
  type        = bool
  default     = true
}


variable "export_custom_routes" {
  description = "Export Custom Routes"
  type        = bool
  default     = true
}

variable "import_custom_routes" {
  description = "Import Custom Routes"
  type        = bool
  default     = true
}

variable "database_name" {
type = string
description = "Database name"
}

variable "sql_database_version" {
    type = string
    description = "Cloud sql database version"
  
}

variable "db_instance_type" {
    type = string
    description = "instance type"
  
}

variable "delete_protection" {
    type = bool
    default = false
    description = "Whether or not to allow Terraform to destroy the instance."
  
}


#load balancer variables

variable "target_tags" {
  description = "List of target tags for health check firewall rule. Exactly one of target_tags or target_service_accounts should be specified."
  type        = list(string)
  default     = []
}

variable "purpose" {
    type = string
    description = "purpose of the subnet"
  
}

variable "role" {
    type = string
    description = "role of the subnet"
  
}
