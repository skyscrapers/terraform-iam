output "permission_set_arns" {
  value = [for ps in aws_ssoadmin_permission_set.this : ps.arn]
}

output "account_assignments" {
  value = [for as in aws_ssoadmin_account_assignment.this : as.id]
}
