output "packer_policy_arn" {
  value = "${aws_iam_policy.packer_policy.arn}"
}

output "packer_policy_name" {
  value = "${aws_iam_policy.packer_policy.name}"
}

output "packer_policy_id" {
  value = "${aws_iam_policy.packer_policy.id}"
}
