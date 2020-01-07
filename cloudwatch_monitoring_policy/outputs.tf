output "iam_policy_arn" {
  description = "ARN of the Cloudwatch monitoring IAM policy"
  value       = aws_iam_policy.cloudwatch_monitoring_policy.arn
}

output "iam_policy_name" {
  description = "Name of the Cloudwatch monitoring IAM policy"
  value       = aws_iam_policy.cloudwatch_monitoring_policy.name
}

output "iam_policy_id" {
  description = "ID of the Cloudwatch monitoring IAM policy"
  value       = aws_iam_policy.cloudwatch_monitoring_policy.id
}
