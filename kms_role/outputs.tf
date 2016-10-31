output "role_arn" {
  value = "${aws_iam_role.packer_role.arn}"
}

output "role_unique_id" {
  value = "${aws_iam_role.packer_role.unique_id}"
}

output "profile_id" {
  value = "${aws_iam_instance_profile.packer_profile.id}"
}

output "profile_arn" {
  value = "${aws_iam_instance_profile.packer_profile.arn}"
}

output "profile_name" {
  value = "${aws_iam_instance_profile.packer_profile.name}"
}

output "policy_id" {
  value = "${aws_iam_role_policy.packer_profile.id}"
}

output "policy_name" {
  value = "${aws_iam_role_policy.packer_profile.name}"
}

output "policy_policy" {
  value = "${aws_iam_role_policy.packer_profile.policy}"
}

output "policy_role" {
  value = "${aws_iam_role_policy.packer_profile.role}"
}
