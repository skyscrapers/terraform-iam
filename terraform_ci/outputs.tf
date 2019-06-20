output "user_arn" {
  description = "The ARN assigned by AWS for this user"
  value       = aws_iam_user.terraform_ci.arn
}

output "user_name" {
  description = "The user's name"
  value       = aws_iam_user.terraform_ci.name
}

output "user_unique_id" {
  description = "The [unique ID](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_identifiers.html#GUIDs) assigned by AWS"
  value       = aws_iam_user.terraform_ci.unique_id
}

output "user_path" {
  description = "Path in which the user is created"
  value       = aws_iam_user.terraform_ci.path
}

output "access_key_id" {
  description = "Access Key Id of the created terraform user"
  value       = aws_iam_access_key.terraform_ci.id
}

output "secret_access_key" {
  description = "The encrypted Secret Access Key of the created terraform user, base64 encoded"
  value       = aws_iam_access_key.terraform_ci.encrypted_secret
}

