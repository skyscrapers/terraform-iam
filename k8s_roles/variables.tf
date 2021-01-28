variable "principal_ids" {
  description = "List of AWS principal ids (or ARNs) that'll be allowed to assume roles in the ops account"
  type        = list(string)
}

variable "roles_path" {
  description = "Path of the roles created"
  default     = "/ops/"
}
