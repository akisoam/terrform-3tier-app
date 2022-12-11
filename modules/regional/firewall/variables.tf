
# Define variables
variable "firewall_name" {
    type = string
    description = "Firewall name"
  
}
variable "direction" {
    type = string
    description = "direction - Ingress/Egress"
  
}

variable "protocol" {
    type = string
    description = "protocol"
  
}

/* variable "vpc_uri_000" {
    type = string
    description = "VPC URI"
  
} */
