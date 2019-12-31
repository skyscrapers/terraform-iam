data "aws_iam_policy_document" "cloudwatch_monitoring_policy" {
  statement {
    sid = "CloudWatchMonitoring"

    actions = [
      "cloudwatch:PutMetricData",
      "cloudwatch:GetMetricStatistics",
      "cloudwatch:ListMetrics",
      "ec2:DescribeTags"
    ]

    effect = "Allow"

    resources = ["*"]
  }
}

resource "aws_iam_policy" "cloudwatch_monitoring_policy" {
  name        = var.name != null ? "cloudwatch_monitoring_${var.name}" : null
  name_prefix = var.name == null ? "cloudwatch_monitoring_" : null
  policy      = data.aws_iam_policy_document.cloudwatch_monitoring_policy.json
}
