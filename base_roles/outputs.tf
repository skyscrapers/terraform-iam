output "admin_role_arn" {
  value = "${aws_iam_role.admin.arn}"
}

output "ro_role_arn" {
  value = "${aws_iam_role.ro.arn}"
}
