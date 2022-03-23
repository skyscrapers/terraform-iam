data "aws_iam_policy_document" "eks_viewer" {
  statement {
    sid    = "EKSViewer"
    effect = "Allow"

    actions = [
      "eks:DescribeNodegroup",
      "eks:ListNodegroups",
      "eks:DescribeCluster",
      "eks:ListClusters",
      "eks:AccessKubernetesApi",
      "ssm:GetParameter",
      "eks:ListUpdates",
      "eks:ListFargateProfiles"
    ]

    resources = ["*"]
  }
}
