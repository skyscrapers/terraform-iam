output "packer_policy_arn" {
  description = "The generated policy ARN"
  value       = "${aws_iam_policy.packer_policy.arn}"
}

output "packer_policy_name" {
  description = "The generated policy name"
  value       = "${aws_iam_policy.packer_policy.name}"
}

output "packer_policy_id" {
  description = "The generated policy id"
  value       = "${aws_iam_policy.packer_policy.id}"
}
