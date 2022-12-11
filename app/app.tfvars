# Define values for variables to be used for VPC resources to be added to VPC

vpc_name_000 = "mycustomvpc"
vpc_description_000 = "coding challenge VPC"
gcp_region = "us-west1"
project = "coding-challenge-370401"

# Define variables to be used for Subnetwork resources to be added to VPC
#subnet1
subnet_coding_challenge_name = "subnet1"
subnet_coding_challenge_description = "Subnetwork 1"
subnet_coding_challenge_range = "10.200.50.0/25"

#subnet2
subnet_coding_challenge2_name   = "proxy-only-subnet"
subnet_coding_challenge2_description = "Subnetwork 2"
subnet_coding_challenge2_range  = "10.200.50.128/25"
purpose                         = "REGIONAL_MANAGED_PROXY"
role                            = "ACTIVE"
google_api_access =  false

## Define the variables to be used for Cloud SQL

database_name               = "test-instance"
sql_database_version        = "POSTGRES_12"
db_instance_type            = "db-f1-micro"

