provider "google" {
  project = "my-sample-project"
  region  = "us-central1"
  zone    = "us-central1-a"
}

module "networking" {
  source = "git::https://github.com/Harsha-VardhanK/gcp-terraform-module-network.git?ref=v1.0.0"

  project_id = "my-sample-project"
  region     = "us-central1"

  vpcs = {
    main = { name = "main-vpc" }
  }

  subnets = {
    vm = {
      vpc_key   = "main"
      name      = "vm-subnet"
      region    = "us-central1"
      cidr      = "10.40.0.0/16"
      secondary = {}
    }
  }

  enable_nat = true
}

module "gce" {
  source = "../../"

  project_id = "my-sample-project"
  region     = "us-central1"
  zone       = "us-central1-a"

  network = module.networking.vpcs["main"]
  subnet  = module.networking.subnets["vm"]

  instances = {
    vm1 = {
      name         = "demo-vm-1"
      machine_type = "e2-medium"
      boot_image   = "debian-cloud/debian-12"
      disk_size_gb = 30
      tags         = ["web"]
    }
  }
}
