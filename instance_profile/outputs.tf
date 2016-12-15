output "iam_id" {
  value = "${aws_iam_instance_profile.profile.id}"
}
output "iam_role_id" {
  value = "${aws_iam_role.role.id}"
}
