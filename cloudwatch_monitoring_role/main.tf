data "aws_iam_policy_document" "cloudwatch_monitoring_policy" {
  statement {
    sid     = "CloudWatchMonitoring"
    actions = ["cloudwatch:PutMetricData", "cloudwatch:GetMetricStatistics", "cloudwatch:GetMetricData", "cloudwatch:ListMetrics", "ec2:DescribeTags"]
    effect  = "Allow"

    resources = ["*"]
  }
}

resource "aws_iam_policy" "cloudwatch_monitoring_policy" {
  name   = "cloudwatch_${var.project}_${var.app}_${var.environment}"
  path   = "/"
  policy = data.aws_iam_policy_document.cloudwatch_monitoring_policy.json
}

resource "aws_iam_role_policy_attachment" "cloudwatch_monitoring_access" {
  role       = var.instance_role
  policy_arn = aws_iam_policy.cloudwatch_monitoring_policy.arn
}

