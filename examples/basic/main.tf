module "launch_template" {
  source  = "terraform-volcenginecc-modules/ecs-launch-template/volcenginecc"
  version = "~> 1.0"

  manage_volumes = var.manage_volumes

  template = {
    name               = var.template_name
    image_id           = var.image_id
    instance_type_id   = "ecs.g3il.large"
    zone_id            = var.zone_id
    subnet_id          = var.subnet_id
    security_group_ids = [var.security_group_id]
    key_pair_name      = var.key_pair_name

    system_volume = {
      volume_type = "ESSD_PL0"
      size        = 40
    }

    instance_tags = {
      Environment = "dev"
      ManagedBy   = "terraform"
      Role        = "web"
    }

    template_tags = {
      Environment = "dev"
      ManagedBy   = "terraform"
    }
  }
}
