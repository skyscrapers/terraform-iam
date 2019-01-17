variable "admin_role_principal_ids" {
  description = "List of AWS principal ids (or ARNs) that'll be allowed to assume the admin role in the ops account"
  type        = "list"
}

variable "readonly_role_principal_ids" {
  description = "List of AWS principal ids (or ARNs) that'll be allowed to assume the readonly role in the ops account"
  type        = "list"
}
