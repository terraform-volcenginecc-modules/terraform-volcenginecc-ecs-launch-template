output "launch_template_id" {
  description = "ID of the managed launch template for use by ECS batch purchase or Auto Scaling consumers."
  value       = volcenginecc_ecs_launch_template.this.launch_template_id
}

output "default_version_number" {
  description = "Default version number returned by the launch template."
  value       = volcenginecc_ecs_launch_template.this.default_version_number
}

output "latest_version_number" {
  description = "Latest version number returned by the launch template."
  value       = volcenginecc_ecs_launch_template.this.latest_version_number
}

output "versions" {
  description = "Additional managed version identifiers keyed by the input versions map."
  value = {
    for key, version in volcenginecc_ecs_launch_template_version.this : key => {
      id             = version.id
      version_number = version.version_number
    }
  }
}
