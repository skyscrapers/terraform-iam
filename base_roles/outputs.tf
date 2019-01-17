output "admin_role_arn" {
  value       = "${aws_iam_role.admin.arn}"
  description = "Admin role ARN"
}

output "ro_role_arn" {
  value       = "${aws_iam_role.ro.arn}"
  description = "Readonly role ARN"
}
