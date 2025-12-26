Terraform GCE Module (Google Cloud)

This Terraform module provisions Google Compute Engine (GCE) virtual machine instances on Google Cloud Platform.

The module is designed to be reusable, scalable, and production-ready, supporting multiple VM instances using a single module invocation. It is intended to be used with an existing VPC and subnet, typically created by a dedicated networking module.

Features

Create one or more GCE VM instances

Support for multiple instances using for_each

Customizable:

Machine type

Boot disk image and size

Network tags

Works with custom VPC and subnet

Suitable for multi-project and CI/CD workflows

Registry-style module structure

Requirements
Name	Version
Terraform	>= 1.5.0
Google Provider	~> 6.0
Inputs
Required Inputs
Name	Description	Type
project_id	GCP project ID	string
region	GCP region	string
zone	GCP zone	string
network	VPC network self-link	string
subnet	Subnet self-link	string
instances	Map of VM instance definitions	map(object)
instances Object Definition
instances = {
  vm1 = {
    name         = string
    machine_type = string
    boot_image   = string
    disk_size_gb = number
    tags         = list(string)
  }
}

Outputs
Name	Description
instance_names	Names of created VM instances
instance_self_links	Self-links of created VM instances
Example Usage
module "gce" {
  source = "git::https://github.com/Harsha-VardhanK/gcp-terraform-module-gce.git?ref=v1.0.0"

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

Networking Notes

This module does not create networking resources

A VPC and subnet must already exist

For private subnets:

Cloud NAT is required for outbound internet access