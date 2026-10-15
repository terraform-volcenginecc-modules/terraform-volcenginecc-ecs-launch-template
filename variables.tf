variable "template" {
  description = "The initial version of the launch template. Existing images, key pairs, subnets, security groups, and IAM roles are caller-owned. Changing a version property creates a replacement version in the provider."

  type = object({
    name               = string
    image_id           = string
    instance_type_id   = string
    zone_id            = string
    subnet_id          = string
    security_group_ids = set(string)
    system_volume = object({
      volume_type          = string
      size                 = number
      delete_with_instance = optional(bool, true)
      snapshot_id          = optional(string)
    })
    data_volumes = optional(map(object({
      volume_type          = string
      size                 = number
      delete_with_instance = optional(bool, true)
      snapshot_id          = optional(string)
    })), {})
    description                   = optional(string)
    project_name                  = optional(string)
    key_pair_name                 = optional(string)
    instance_name                 = optional(string)
    host_name                     = optional(string)
    user_data                     = optional(string)
    instance_charge_type          = optional(string, "PostPaid")
    keep_image_credential         = optional(bool)
    security_enhancement_strategy = optional(string)
    spot_strategy                 = optional(string, "NoSpot")
    spot_price_limit              = optional(number)
    version_description           = optional(string)
    instance_tags                 = optional(map(string), {})
    template_tags                 = optional(map(string), {})
  })

  validation {
    condition = (
      length(trimspace(var.template.name)) > 0 &&
      length(trimspace(var.template.image_id)) > 0 &&
      length(trimspace(var.template.instance_type_id)) > 0 &&
      length(trimspace(var.template.zone_id)) > 0 &&
      length(trimspace(var.template.subnet_id)) > 0 &&
      length(var.template.security_group_ids) > 0 &&
      length(var.template.security_group_ids) <= 5
    )
    error_message = "template requires non-empty name, image_id, instance_type_id, zone_id, subnet_id, and one to five security_group_ids."
  }

  validation {
    condition = (
      var.template.system_volume.size >= 10 &&
      var.template.system_volume.size <= 32768 &&
      length(var.template.data_volumes) <= 15 &&
      alltrue([for volume in values(var.template.data_volumes) : volume.size >= 10 && volume.size <= 32768])
    )
    error_message = "The system volume and every data volume must be 10 to 32768 GiB; at most 15 data volumes are allowed."
  }

  validation {
    condition = (
      contains(["NoSpot", "SpotAsPriceGo", "SpotWithPriceLimit"], var.template.spot_strategy) &&
      (var.template.spot_strategy == "SpotWithPriceLimit" ? try(var.template.spot_price_limit > 0, false) : var.template.spot_price_limit == null)
    )
    error_message = "spot_price_limit must be set only for SpotWithPriceLimit and be greater than zero."
  }

  validation {
    condition = var.template.user_data == null ? true : (
      !can(regex("(?i)(access[_-]?key|secret[_-]?key|aws_access_key_id|aws_secret_access_key|volcengine_access_key|volcengine_secret_key|akia[0-9a-z]{16}|aklt[0-9a-z]+)", var.template.user_data)) &&
      !can(regex("(?i)(access[_-]?key|secret[_-]?key|aws_access_key_id|aws_secret_access_key|volcengine_access_key|volcengine_secret_key|akia[0-9a-z]{16}|aklt[0-9a-z]+)", try(base64decode(var.template.user_data), "")))
    )
    error_message = "user_data must not contain plaintext credentials, including Base64-encoded credentials."
  }
}

variable "versions" {
  description = "Additional launch-template versions keyed by stable logical names. Changing a key changes the Terraform resource address. Each version inherits nothing from the initial version; repeat every required launch parameter."

  type = map(object({
    image_id           = string
    instance_type_id   = string
    zone_id            = string
    subnet_id          = string
    security_group_ids = set(string)
    system_volume = object({
      volume_type          = string
      size                 = number
      delete_with_instance = optional(bool, true)
      snapshot_id          = optional(string)
    })
    data_volumes = optional(map(object({
      volume_type          = string
      size                 = number
      delete_with_instance = optional(bool, true)
      snapshot_id          = optional(string)
    })), {})
    description                   = optional(string)
    project_name                  = optional(string)
    key_pair_name                 = optional(string)
    instance_name                 = optional(string)
    host_name                     = optional(string)
    user_data                     = optional(string)
    instance_charge_type          = optional(string, "PostPaid")
    keep_image_credential         = optional(bool)
    security_enhancement_strategy = optional(string)
    spot_strategy                 = optional(string, "NoSpot")
    spot_price_limit              = optional(number)
    version_description           = optional(string)
    instance_tags                 = optional(map(string), {})
  }))
  default = {}

  validation {
    condition = alltrue([
      for version in values(var.versions) :
      length(trimspace(version.image_id)) > 0 &&
      length(trimspace(version.instance_type_id)) > 0 &&
      length(trimspace(version.zone_id)) > 0 &&
      length(trimspace(version.subnet_id)) > 0 &&
      length(version.security_group_ids) > 0 &&
      length(version.security_group_ids) <= 5 &&
      version.system_volume.size >= 10 &&
      version.system_volume.size <= 32768 &&
      length(version.data_volumes) <= 15 &&
      alltrue([for volume in values(version.data_volumes) : volume.size >= 10 && volume.size <= 32768]) &&
      contains(["NoSpot", "SpotAsPriceGo", "SpotWithPriceLimit"], version.spot_strategy) &&
      (version.spot_strategy == "SpotWithPriceLimit" ? try(version.spot_price_limit > 0, false) : version.spot_price_limit == null)
    ])
    error_message = "Every version requires image, type, zone, subnet, one to five security groups, valid disks, and a valid Spot configuration."
  }

  validation {
    condition = alltrue([
      for version in values(var.versions) :
      version.user_data == null ? true : (
        !can(regex("(?i)(access[_-]?key|secret[_-]?key|aws_access_key_id|aws_secret_access_key|volcengine_access_key|volcengine_secret_key|akia[0-9a-z]{16}|aklt[0-9a-z]+)", version.user_data)) &&
        !can(regex("(?i)(access[_-]?key|secret[_-]?key|aws_access_key_id|aws_secret_access_key|volcengine_access_key|volcengine_secret_key|akia[0-9a-z]{16}|aklt[0-9a-z]+)", try(base64decode(version.user_data), "")))
      )
    ])
    error_message = "version user_data must not contain plaintext credentials, including Base64-encoded credentials."
  }
}

variable "manage_volumes" {
  type        = bool
  description = "Whether to send system_volume and data_volumes to the Provider. Defaults to false because Provider v0.0.70 returns volumes as null after create; enable only after using a Provider version that preserves volume state."
  default     = false
}

variable "default_version_number" {
  type        = number
  description = "Default template version number. Set this to an existing version number; it is not derived from versions because provider version numbers are computed after creation."
  default     = null

  validation {
    condition     = var.default_version_number == null ? true : var.default_version_number >= 1
    error_message = "default_version_number must be null or a positive version number."
  }
}
