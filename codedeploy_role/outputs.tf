output "role_arn" {
  description = "The Amazon Resource Name (ARN) specifying the role."
  value       = aws_iam_role.codedeploy_role.arn
}

output "role_name" {
  description = "The name of the role."
  value       = aws_iam_role.codedeploy_role.name
}

output "role_unique_id" {
  description = "The stable and unique string identifying the role."
  value       = aws_iam_role.codedeploy_role.unique_id
}

