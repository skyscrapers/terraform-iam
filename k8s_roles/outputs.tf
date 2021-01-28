output "k8s_admin_role_arn" {
  value       = aws_iam_role.k8s_admin.arn
  description = "k8s-admin role ARN"
}

output "k8s_developer_role_arn" {
  value       = aws_iam_role.k8s_developer.arn
  description = "k8s-developer role ARN"
}
