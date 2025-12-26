resource "google_compute_instance" "vm" {
  for_each = var.instances

  project      = var.project_id
  zone         = var.zone
  name         = each.value.name
  machine_type = each.value.machine_type

  boot_disk {
    initialize_params {
      image = each.value.boot_image
      size  = each.value.disk_size_gb
    }
  }

  network_interface {
    network    = var.network
    subnetwork = var.subnet
  }

  tags = each.value.tags

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}
