# terraform-volcenginecc-ecs-launch-template

## 概述

基于 `volcenginecc` Provider 管理火山引擎 ECS LAUNCH TEMPLATE 资源的 Terraform 模块。调用方负责 Provider 凭据、地域配置，以及通过 ID 传入的外部资源。

## 用法

```hcl
module "ecs_launch_template" {
  source  = "terraform-volcenginecc-modules/ecs-launch-template/volcenginecc"
  version = "~> 1.0"

  # 请设置适用于当前环境的必填模块输入。
}
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
| `volcenginecc_ecs_launch_template` | 模块定义的 volcenginecc_ecs_launch_template。 |
| `volcenginecc_ecs_launch_template_version` | 模块定义的 volcenginecc_ecs_launch_template_version。 |

## 输入

| 名称 | 说明 |
|---|---|
| `template` | 模块定义的 template。 |
| `versions` | 模块定义的 versions。 |
| `manage_volumes` | 模块定义的 manage_volumes。 |
| `default_version_number` | 模块定义的 default_version_number。 |

## 输出

| 名称 | 说明 |
|---|---|
| `launch_template_id` | 模块定义的 launch_template_id。 |
| `default_version_number` | 模块定义的 default_version_number。 |
| `latest_version_number` | 模块定义的 latest_version_number。 |
| `versions` | 模块定义的 versions。 |

## 示例

- `basic`：可独立运行的 basic 配置。
- `complete`：可独立运行的 complete 配置。

## 说明

- 请通过 Provider 支持的方式配置凭据，不要将访问密钥写入模块文件。
- 执行变更前请审阅替换行为及 Provider 限制。
- apply 后请再次执行 `terraform plan`，并确认第二次 plan 无变更。
