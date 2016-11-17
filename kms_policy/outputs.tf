output "iam_policy_arn" {
  value = "${aws_iam_policy.kms_policy.arn}"
}

output "iam_policy_name" {
  value = "${aws_iam_policy.kms_policy.name}"
}

output "iam_policy_id" {
  value = "${aws_iam_policy.kms_policy.id}"
}
