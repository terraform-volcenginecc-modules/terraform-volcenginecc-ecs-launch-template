output "launch_template_id" {
  description = "Created launch template ID."
  value       = module.launch_template.launch_template_id
}

output "versions" {
  description = "Managed additional template versions."
  value       = module.launch_template.versions
}
