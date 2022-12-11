terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}

provider "google" {
  credentials = file("../../keys/coding-challenge-370401-961f06711f53.json")
  project     = var.project
  region      = var.gcp_region
}

##  GCP VPC

module "vpc" {
  source    = "../modules/global/vpc"
  gcp_region              = var.gcp_region
  project                 = var.project
  vpc_name_000            = var.vpc_name_000
  vpc_description_000     = var.vpc_description_000
  auto_create_subnetworks = var.auto_create_subnetworks
  routing_mode            = var.routing_mode
}

module "coding_challengesubnetwork" {
  source  = "../modules/regional/subnetworks/subnet1/"
  project                             = var.project
  vpc_uri_000                         = module.vpc.vpc_uri_000
  flow_log_aggregation_interval       = var.flow_log_aggregation_interval
  flow_log_sampling_rate              = var.flow_log_sampling_rate
  flow_log_metadata                   = var.flow_log_metadata
  google_api_access                   = var.google_api_access
  subnet_coding_challenge_name             = var.subnet_coding_challenge_name
  subnet_coding_challenge_description      = var.subnet_coding_challenge_description
  subnet_coding_challenge_range            = var.subnet_coding_challenge_range
}

module "coding_challengesubnetwork2" {
  source  = "../modules/regional/subnetworks/subnet2/"
  project                             = var.project
  vpc_uri_000                         = module.vpc.vpc_uri_000
  flow_log_aggregation_interval       = var.flow_log_aggregation_interval
  flow_log_sampling_rate              = var.flow_log_sampling_rate
  flow_log_metadata                   = var.flow_log_metadata
  google_api_access                   = var.google_api_access
  subnet_coding_challenge2_name             = var.subnet_coding_challenge2_name
  subnet_coding_challenge2_description      = var.subnet_coding_challenge2_description
  subnet_coding_challenge2_range            = var.subnet_coding_challenge2_range
  purpose                             = var.purpose
  role                                = var.role
}

resource "random_id" "db_name_suffix" {
  byte_length = 4
}

module "cloudsql" {
source = "../modules/regional/sql"
    database_name           = var.database_name
    sql_database_version    = var.sql_database_version
    delete_protection       = var.delete_protection
    db_instance_type        = var.db_instance_type
}


############################ TODO: Below should be tranformed into modules ##########################################

resource "google_compute_firewall" "default" {
  name = "fw-allow-health-check"
  allow {
    protocol = "tcp"
  }
  direction     = "INGRESS"
  network       = module.vpc.vpc_uri_000
  priority      = 1000
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
  target_tags   = ["load-balanced-backend"]
}

# [START cloudloadbalancing_proxy_firewall_rllxlb_example]
resource "google_compute_firewall" "allow_proxy" {
  name = "fw-allow-proxies"
  allow {
    ports    = ["443"]
    protocol = "tcp"
  }
  allow {
    ports    = ["80"]
    protocol = "tcp"
  }
  allow {
    ports    = ["8080"]
    protocol = "tcp"
  }
  direction     = "INGRESS"
  network       = module.vpc.vpc_uri_000
  priority      = 1000
  source_ranges = ["10.200.50.128/25"]
  target_tags   = ["load-balanced-backend"]
}
# [END cloudloadbalancing_proxy_firewall_rllxlb_example]

# [START cloudloadbalancing_instance_template_rllxlb_example]
resource "google_compute_instance_template" "default" {
  name = "l7-xlb-backend-template"
  disk {
    auto_delete  = true
    boot         = true
    device_name  = "persistent-disk-0"
    mode         = "READ_WRITE"
    source_image = "projects/debian-cloud/global/images/family/debian-10"
    type         = "PERSISTENT"
  }
  labels = {
    managed-by-cnrm = "true"
  }
  machine_type = "n1-standard-1"
  metadata = {
    startup-script = <<EOF
    #! /bin/bash
    sudo apt-get update
    sudo apt-get install nginx -y
    EOF
  }
  network_interface {
    access_config {
      network_tier = "PREMIUM"
    }
    network    = module.vpc.vpc_uri_000
    subnetwork = module.coding_challengesubnetwork.app_subnetwork_uri
  }
  region = "us-west1"
  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
    provisioning_model  = "STANDARD"
  }
  service_account {
    email  = "default"
    scopes = ["https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring.write", "https://www.googleapis.com/auth/pubsub", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol", "https://www.googleapis.com/auth/trace.append"]
  }
  tags = ["load-balanced-backend"]
}

resource "google_compute_instance_group_manager" "default" {
  name = "l7-xlb-backend-example"
  zone = "us-west1-a"
  named_port {
    name = "http"
    port = 80
  }
  version {
    instance_template = google_compute_instance_template.default.id
    name              = "primary"
  }
  base_instance_name = "vm"
  target_size        = 2
}


resource "google_compute_address" "default" {
  name         = "address-name"
  address_type = "EXTERNAL"
  network_tier = "STANDARD"
  region       = "us-west1"
}


resource "google_compute_region_health_check" "default" {
  name               = "l7-xlb-basic-check"
  check_interval_sec = 5
  healthy_threshold  = 2
  http_health_check {
    port_specification = "USE_SERVING_PORT"
    proxy_header       = "NONE"
    request_path       = "/"
  }
  region              = "us-west1"
  timeout_sec         = 5
  unhealthy_threshold = 2
}

resource "google_compute_region_backend_service" "default" {
  name                  = "l7-xlb-backend-service"
  region                = "us-west1"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  health_checks         = [google_compute_region_health_check.default.id]
  protocol              = "HTTP"
  session_affinity      = "NONE"
  timeout_sec           = 30
  backend {
    group           = google_compute_instance_group_manager.default.instance_group
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 1.0
  }
}

resource "google_compute_region_url_map" "default" {
  name            = "regional-l7-xlb-map"
  region          = "us-west1"
  default_service = google_compute_region_backend_service.default.id
}

resource "google_compute_region_target_http_proxy" "default" {
  name    = "l7-xlb-proxy"
  region  = "us-west1"
  url_map = google_compute_region_url_map.default.id
}

resource "google_compute_forwarding_rule" "default" {
  name       = "l7-xlb-forwarding-rule"
  depends_on = [module.coding_challengesubnetwork2]
  region     = "us-west1"

  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  port_range            = "80"
  target                = google_compute_region_target_http_proxy.default.id
  network               = module.vpc.vpc_uri_000
  ip_address            = google_compute_address.default.id
  network_tier          = "STANDARD"
}