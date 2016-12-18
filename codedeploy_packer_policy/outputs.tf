output "iam_policy_arn" {
  value = "${aws_iam_policy.codedeploy_install_policy.arn}"
}

output "iam_policy_name" {
  value = "${aws_iam_policy.codedeploy_install_policy.name}"
}

output "iam_policy_id" {
  value = "${aws_iam_policy.codedeploy_install_policy.id}"
}
