variable "sso_instance_id" {
  description = ""
  type        = string
}

variable "sso_instance_arn" {
  description = ""
  type        = string
}

variable "group_ids" {
  description = "Map of Identity Store group display name to group id. Must contain every `group` used in `permission_sets`."
  type        = map(string)
}

variable "permission_sets" {
  description = ""
  type = map(object({
    description      = string
    group            = string
    managed_policies = list(string)
    inline_policies  = list(string)
    eks_access       = bool
    account_ids      = list(string)
  }))

}

variable "default_ps_session_duration" {
  description = ""
  type        = string
  default     = "PT8H"
}
