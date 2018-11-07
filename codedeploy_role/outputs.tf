output "role_arn" {
  value = "${aws_iam_role.codedeploy_role.arn}"
}

output "role_name" {
  value = "${aws_iam_role.codedeploy_role.name}"
}

output "role_unique_id" {
  value = "${aws_iam_role.codedeploy_role.unique_id}"
}
