resource "aws_iam_user" "user" {
  count = "${length(var.user_names)}"
  name  = "${element(var.user_names, count.index)}"
}

resource "aws_iam_user_login_profile" "user_login" {
  count                   = "${length(var.user_names)}"
  user                    = "${element(aws_iam_user.user.*.name, count.index)}"
  pgp_key                 = "${var.pgp_key}"
  password_reset_required = "true"
}
