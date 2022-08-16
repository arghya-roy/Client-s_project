resource "google_compute_instance" "default" {
  name         = "instance-kay"
  machine_type = "e2-micro"

  boot_disk {
    initialize_params {
      image = "ubuntu-2004-lts"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    subnetwork = google_compute_subnetwork.public-subnetwork.name

    access_config {
    }
  }
metadata = {
    ssh-keys = join("\n", [for key in var.ssh_keys : "${key.user}:${key.publickey}"])
}


provisioner "remote-exec" {
     inline = [
       "sudo apt install nginx -y",
       "sudo nginx -v",
       "sudo rm /var/www/html/*",
       "sudo apt install git -y",
       "git clone https://github.com/yenchiah/project-website-template.git",
       "sudo cp -r project-website-template/* /var/www/html/"
     ]

   connection {
     type = "ssh"
     user = "arghy"
     private_key = file("./google_key.pem") // store the in that location where this file located
     host = self.network_interface.0.access_config.0.nat_ip
   }
   }

  tags = [tolist(google_compute_firewall.ssh.target_tags)[0], tolist(google_compute_firewall.http.target_tags)[0]]
}