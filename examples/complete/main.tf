module "launch_template" {
  source  = "terraform-volcenginecc-modules/ecs-launch-template/volcenginecc"
  version = "~> 1.0"

  default_version_number = 1
  manage_volumes         = var.manage_volumes

  template = {
    name                = var.template_name
    image_id            = var.image_id
    instance_type_id    = "ecs.g3il.large"
    zone_id             = var.zone_id
    subnet_id           = var.subnet_id
    security_group_ids  = [var.security_group_id]
    key_pair_name       = var.key_pair_name
    instance_name       = "complete-app"
    user_data           = base64encode("#!/bin/bash\nsystemctl enable nginx")
    version_description = "Initial application image with bootstrap UserData"

    system_volume = {
      volume_type = "ESSD_PL0"
      size        = 40
    }

    data_volumes = {
      application = {
        volume_type = "ESSD_FlexPL"
        size        = 100
      }
    }

    instance_tags = {
      Environment = "prod"
      ManagedBy   = "terraform"
      Role        = "application"
    }

    template_tags = {
      Environment = "prod"
      ManagedBy   = "terraform"
    }
  }

  versions = {
    spot_batch = {
      image_id            = var.image_id
      instance_type_id    = "ecs.g3il.large"
      zone_id             = var.zone_id
      subnet_id           = var.subnet_id
      security_group_ids  = [var.security_group_id]
      key_pair_name       = var.key_pair_name
      instance_name       = "complete-batch"
      user_data           = base64encode("#!/bin/bash\necho batch-worker-ready")
      spot_strategy       = "SpotWithPriceLimit"
      spot_price_limit    = 0.5
      version_description = "Price-limited Spot batch workers"

      system_volume = {
        volume_type = "ESSD_PL0"
        size        = 40
      }

      data_volumes = {
        workspace = {
          volume_type = "ESSD_FlexPL"
          size        = 100
        }
      }

      instance_tags = {
        Environment = "prod"
        ManagedBy   = "terraform"
        Role        = "batch"
      }
    }
  }
}
