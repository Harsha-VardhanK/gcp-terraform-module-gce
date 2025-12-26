variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
}

variable "zone" {
  description = "GCP zone"
  type        = string
}

variable "network" {
  description = "VPC network self link"
  type        = string
}

variable "subnet" {
  description = "Subnet self link"
  type        = string
}

variable "instances" {
  description = "Map of GCE instances"
  type = map(object({
    name         = string
    machine_type = string
    boot_image   = string
    disk_size_gb = number
    tags         = list(string)
  }))
}
