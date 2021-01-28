data "aws_iam_policy_document" "k8s_admin_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "AWS"
      identifiers = var.principal_ids
    }
  }
}

resource "aws_iam_role" "k8s_admin" {
  name               = "k8s-admin"
  path               = var.roles_path
  description        = "This role has admin access inside the EKS clusters running in this account"
  assume_role_policy = data.aws_iam_policy_document.k8s_admin_assume_role_policy.json
}

data "aws_iam_policy_document" "k8s_developer_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "AWS"
      identifiers = var.principal_ids
    }
  }
}

resource "aws_iam_role" "k8s_developer" {
  name               = "k8s-developer"
  path               = var.roles_path
  description        = "This role has developer access inside the EKS clusters running in this account"
  assume_role_policy = data.aws_iam_policy_document.k8s_developer_assume_role_policy.json
}

data "aws_iam_policy_document" "eks_read_access" {
  statement {
    effect = "Allow"
    actions = [
      "eks:ListNodegroups",
      "eks:DescribeFargateProfile",
      "eks:ListTagsForResource",
      "eks:ListAddons",
      "eks:DescribeAddon",
      "eks:ListFargateProfiles",
      "eks:DescribeNodegroup",
      "eks:ListUpdates",
      "eks:DescribeUpdate",
      "eks:DescribeCluster",
      "eks:ListClusters",
      "eks:DescribeAddonVersions"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "eks_read_access" {
  name   = "EKSReadAccess"
  policy = data.aws_iam_policy_document.eks_read_access.json
}

resource "aws_iam_role_policy_attachment" "k8s_admin_eks_access" {
  role       = aws_iam_role.k8s_admin.name
  policy_arn = aws_iam_policy.eks_read_access.arn
}

resource "aws_iam_role_policy_attachment" "k8s_developer_eks_access" {
  role       = aws_iam_role.k8s_developer.name
  policy_arn = aws_iam_policy.eks_read_access.arn
}
