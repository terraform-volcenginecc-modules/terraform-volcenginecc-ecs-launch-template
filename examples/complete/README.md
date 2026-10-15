# COMPLETE ECS LAUNCH TEMPLATE Example

## Overview

Runnable complete configuration for the ECS LAUNCH TEMPLATE module. It configures the provider from input variables and calls the published Registry module.

## Usage

```shell
terraform init
terraform plan
terraform apply
terraform plan
terraform destroy
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
| `terraform-volcenginecc-modules/ecs-launch-template/volcenginecc` | Published ECS LAUNCH TEMPLATE module. |

## Inputs

| Name | Description |
|---|---|
| `template_name` | Module-defined template_name. |
| `manage_volumes` | Module-defined manage_volumes. |
| `zone_id` | Module-defined zone_id. |
| `image_id` | Module-defined image_id. |
| `subnet_id` | Module-defined subnet_id. |
| `security_group_id` | Module-defined security_group_id. |
| `key_pair_name` | Module-defined key_pair_name. |

## Outputs

| Name | Description |
|---|---|
| `launch_template_id` | Module-defined launch_template_id. |
| `versions` | Module-defined versions. |

## Examples

This directory is the complete example.

## Notes

- Supply credentials through supported provider configuration, never in source files.
- The final plan after apply must report no changes before the configuration is accepted.
