
resource "google_compute_firewall" "http" {
  name    = "${google_compute_network.vpc_network.name}http-server"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  target_tags = ["http-server"]
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "ssh" {
  name    = "${google_compute_network.vpc_network.name}ssh"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags = ["ssh-server"]
  source_ranges = ["0.0.0.0/0"]
}
