variable "admin_role_principal_ids" {
  description = "List of AWS principal ids (or ARNs) that'll be allowed to assume the admin role in the ops account"
  type        = list(string)
}

variable "readonly_role_principal_ids" {
  description = "List of AWS principal ids (or ARNs) that'll be allowed to assume the readonly role in the ops account"
  type        = list(string)
}

variable "roles_path" {
  description = "Path of the roles created"
  default = "/ops/"
}
