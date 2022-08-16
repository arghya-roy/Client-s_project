resource "google_compute_network" "vpc_network" {
name = "terraform-network"
auto_create_subnetworks = false
}
resource "google_compute_subnetwork" "public-subnetwork" {
name = "terraform-subnetwork"
ip_cidr_range = "10.2.0.0/16"
region = "asia-south1"
network = google_compute_network.vpc_network.name
}