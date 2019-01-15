variable "admin_role_principals_arns" {
  description = "List of AWS principal ARNs that'll be allowed to assume the admin role in the ops account"
  type        = "list"
}

variable "admin_account_id" {
  description = "Id of the AWS account of the admin account"
}
