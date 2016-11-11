output "unique_id" {
  value = ["${aws_iam_user.user.*.name}"]
}

output "passwords" {
  value = ["${aws_iam_user_login_profile.user_login.*.encrypted_password}"]
}

output "arns" {
  value = ["${aws_iam_user.user.*.arn}"]
}
