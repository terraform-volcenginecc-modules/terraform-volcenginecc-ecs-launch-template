# terraform-volcenginecc-ecs-launch-template

## Overview

Terraform module for managing Volcengine ECS LAUNCH TEMPLATE resources with the `volcenginecc` provider. The caller owns provider authentication, region configuration, and external resources passed by ID.

## Usage

```hcl
module "ecs_launch_template" {
  source  = "terraform-volcenginecc-modules/ecs-launch-template/volcenginecc"
  version = "~> 1.0"

  # Set the required module inputs for your environment.
}
```

## Requirements

| Name | Version |
|---|---|
| Terraform | `>= 1.5.7` |
| OpenTofu | `>= 1.11.8` |

## Providers

| Name | Source |
|---|---|
| `volcenginecc` | `volcengine/volcenginecc` |

## Resources

| Name | Description |
|---|---|
| `volcenginecc_ecs_launch_template` | Module-defined volcenginecc_ecs_launch_template. |
| `volcenginecc_ecs_launch_template_version` | Module-defined volcenginecc_ecs_launch_template_version. |

## Inputs

| Name | Description |
|---|---|
| `template` | Module-defined template. |
| `versions` | Module-defined versions. |
| `manage_volumes` | Module-defined manage_volumes. |
| `default_version_number` | Module-defined default_version_number. |

## Outputs

| Name | Description |
|---|---|
| `launch_template_id` | Module-defined launch_template_id. |
| `default_version_number` | Module-defined default_version_number. |
| `latest_version_number` | Module-defined latest_version_number. |
| `versions` | Module-defined versions. |

## Examples

- `basic`: independently runnable basic configuration.
- `complete`: independently runnable complete configuration.

## Notes

- Configure credentials using supported provider mechanisms; do not put access keys in module files.
- Review replacement behavior and provider constraints before applying changes.
- Run `terraform plan` after apply and confirm that the second plan has no changes.
