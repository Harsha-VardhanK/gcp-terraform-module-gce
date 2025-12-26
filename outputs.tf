output "instance_names" {
  description = "Names of GCE instances"
  value       = { for k, v in google_compute_instance.vm : k => v.name }
}

output "instance_self_links" {
  description = "Self links of GCE instances"
  value       = { for k, v in google_compute_instance.vm : k => v.self_link }
}
