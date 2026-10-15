# COMPLETE ECS LAUNCH TEMPLATE 示例

## 概述

ECS LAUNCH TEMPLATE 模块的可运行 complete 配置。它从输入变量设置 Provider，并调用已发布的 Registry 模块。

## 用法

```shell
terraform init
terraform plan
terraform apply
terraform plan
terraform destroy
```

## 依赖要求

| 名称 | 版本 |
|---|---|
| Terraform | `>= 1.5.7` |
| OpenTofu | `>= 1.11.8` |

## Providers

| 名称 | 来源 |
|---|---|
| `volcenginecc` | `volcengine/volcenginecc` |

## 资源

| 名称 | 说明 |
|---|---|
| `terraform-volcenginecc-modules/ecs-launch-template/volcenginecc` | 已发布的 ECS LAUNCH TEMPLATE 模块。 |

## 输入

| 名称 | 说明 |
|---|---|
| `template_name` | 模块定义的 template_name。 |
| `manage_volumes` | 模块定义的 manage_volumes。 |
| `zone_id` | 模块定义的 zone_id。 |
| `image_id` | 模块定义的 image_id。 |
| `subnet_id` | 模块定义的 subnet_id。 |
| `security_group_id` | 模块定义的 security_group_id。 |
| `key_pair_name` | 模块定义的 key_pair_name。 |

## 输出

| 名称 | 说明 |
|---|---|
| `launch_template_id` | 模块定义的 launch_template_id。 |
| `versions` | 模块定义的 versions。 |

## 示例

本目录即为 complete 示例。

## 说明

- 请通过 Provider 支持的配置提供凭据，绝不应写入源文件。
- apply 后的最终 plan 必须报告无变更，才能接受该配置。
