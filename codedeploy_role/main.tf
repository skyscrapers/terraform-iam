
resource "aws_iam_role_policy" "codedeploy_policy_sns" {
    count = "${var.sns_notify ? 1 : 0}"
    name = "codedeploy"
    role = "${aws_iam_role.codedeploy_role.id}"
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "autoscaling:CompleteLifecycleAction",
                "autoscaling:DeleteLifecycleHook",
                "autoscaling:DescribeAutoScalingGroups",
                "autoscaling:DescribeLifecycleHooks",
                "autoscaling:PutLifecycleHook",
                "autoscaling:RecordLifecycleActionHeartbeat",
                "ec2:DescribeInstances",
                "ec2:DescribeInstanceStatus",
                "tag:GetTags",
                "tag:GetResources",
                "sns:Publish"

            ],
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "codedeploy_policy" {
    count = "${var.sns_notify ? 0 : 1}"
    name = "codedeploy"
    role = "${aws_iam_role.codedeploy_role.id}"
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "autoscaling:CompleteLifecycleAction",
                "autoscaling:DeleteLifecycleHook",
                "autoscaling:DescribeAutoScalingGroups",
                "autoscaling:DescribeLifecycleHooks",
                "autoscaling:PutLifecycleHook",
                "autoscaling:RecordLifecycleActionHeartbeat",
                "ec2:DescribeInstances",
                "ec2:DescribeInstanceStatus",
                "tag:GetTags",
                "tag:GetResources"

            ],
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_role" "codedeploy_role" {
    name = "codedeploy-role"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "codedeploy.${var.region}.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}
