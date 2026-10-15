variable "template_name" {
  type        = string
  description = "Unique launch template name."
  default     = "complete-application-template"
}

variable "manage_volumes" {
  type        = bool
  description = "Whether to send explicit volume configuration to the Provider."
  default     = false
}

variable "zone_id" {
  type        = string
  description = "Availability zone of the existing subnet and selected instance type."
}

variable "image_id" {
  type        = string
  description = "Existing Linux image ID compatible with the selected instance type."
}

variable "subnet_id" {
  type        = string
  description = "Existing subnet ID."
}

variable "security_group_id" {
  type        = string
  description = "Existing security group ID."
}

variable "key_pair_name" {
  type        = string
  description = "Existing key pair name."
}
