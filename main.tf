terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  credentials = file("/home/xxch/GCP_IAM_KEYS/terraform.json")

  project = "industrious-eye-334218"
  region  = "europe-north1"
  zone    = "europe-north1-a"
}

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "e2-micro"

  boot_disk {
    initialize_params {
      image = "ubuntu-2004-focal-v20211202"
    }
  }

  tags = ["http-server"]

  metadata = {
    ssh-keys = "xxch:${file("/home/xxch/GCP_IAM_KEYS/google_cloud.pub")}" 
}

  metadata_startup_script = file("startup-script.sh")

  network_interface {
    network = "default"
    access_config {
    }
  }
}

output "instance_ip" {
      value = google_compute_instance.vm_instance.network_interface.0.access_config.0.nat_ip
}