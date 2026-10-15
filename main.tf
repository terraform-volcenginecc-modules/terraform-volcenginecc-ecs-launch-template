locals {
  initial_volumes = concat(
    [merge(
      {
        volume_type          = var.template.system_volume.volume_type
        size                 = var.template.system_volume.size
        delete_with_instance = var.template.system_volume.delete_with_instance
      },
      var.template.system_volume.snapshot_id == null ? {} : { snapshot_id = var.template.system_volume.snapshot_id },
    )],
    [for volume in values(var.template.data_volumes) : merge(
      {
        volume_type          = volume.volume_type
        size                 = volume.size
        delete_with_instance = volume.delete_with_instance
      },
      volume.snapshot_id == null ? {} : { snapshot_id = volume.snapshot_id },
    )],
  )

  initial_version = merge(
    {
      image_id             = var.template.image_id
      instance_type_id     = var.template.instance_type_id
      zone_id              = var.template.zone_id
      network_interfaces   = [{ subnet_id = var.template.subnet_id, security_group_ids = var.template.security_group_ids }]
      instance_charge_type = var.template.instance_charge_type
      spot_strategy        = var.template.spot_strategy
      tags                 = [for key, value in var.template.instance_tags : { key = key, value = value }]
    },
    var.manage_volumes ? { volumes = local.initial_volumes } : {},
    var.template.description == null ? {} : { description = var.template.description },
    var.template.project_name == null ? {} : { project_name = var.template.project_name },
    var.template.key_pair_name == null ? {} : { key_pair_name = var.template.key_pair_name },
    var.template.instance_name == null ? {} : { instance_name = var.template.instance_name },
    var.template.host_name == null ? {} : { host_name = var.template.host_name },
    var.template.user_data == null ? {} : { user_data = var.template.user_data },
    var.template.keep_image_credential == null ? {} : { keep_image_credential = var.template.keep_image_credential },
    var.template.security_enhancement_strategy == null ? {} : { security_enhancement_strategy = var.template.security_enhancement_strategy },
    var.template.spot_price_limit == null ? {} : { spot_price_limit = var.template.spot_price_limit },
    var.template.version_description == null ? {} : { version_description = var.template.version_description },
  )
}

resource "volcenginecc_ecs_launch_template" "this" {
  launch_template_name         = var.template.name
  launch_template_version      = local.initial_version
  default_version_number       = var.default_version_number
  launch_template_project_name = var.template.project_name
  launch_template_tags         = [for key, value in var.template.template_tags : { key = key, value = value }]
}

resource "volcenginecc_ecs_launch_template_version" "this" {
  for_each = var.versions

  launch_template_id   = volcenginecc_ecs_launch_template.this.launch_template_id
  image_id             = each.value.image_id
  instance_type_id     = each.value.instance_type_id
  zone_id              = each.value.zone_id
  instance_charge_type = each.value.instance_charge_type
  spot_strategy        = each.value.spot_strategy
  network_interfaces = [{
    subnet_id          = each.value.subnet_id
    security_group_ids = each.value.security_group_ids
  }]
  volumes = var.manage_volumes ? concat(
    [merge(
      {
        volume_type          = each.value.system_volume.volume_type
        size                 = each.value.system_volume.size
        delete_with_instance = each.value.system_volume.delete_with_instance
      },
      each.value.system_volume.snapshot_id == null ? {} : { snapshot_id = each.value.system_volume.snapshot_id },
    )],
    [for volume in values(each.value.data_volumes) : merge(
      {
        volume_type          = volume.volume_type
        size                 = volume.size
        delete_with_instance = volume.delete_with_instance
      },
      volume.snapshot_id == null ? {} : { snapshot_id = volume.snapshot_id },
    )],
  ) : null
  tags = [for key, value in each.value.instance_tags : { key = key, value = value }]

  description                   = each.value.description
  project_name                  = each.value.project_name
  key_pair_name                 = each.value.key_pair_name
  instance_name                 = each.value.instance_name
  host_name                     = each.value.host_name
  user_data                     = each.value.user_data
  keep_image_credential         = each.value.keep_image_credential
  security_enhancement_strategy = each.value.security_enhancement_strategy
  spot_price_limit              = each.value.spot_price_limit
  version_description           = each.value.version_description
}
