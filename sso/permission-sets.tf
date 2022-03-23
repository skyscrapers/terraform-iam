locals {
  managed_policy_attachments = flatten([
    for ps_name, value in var.permission_sets : [
      for policy in value.managed_policies : {
        ps_name    = ps_name
        policy_arn = policy
      }
    ]
  ])
  managed_policy_attachments_map = {
    for policy in local.managed_policy_attachments : "${policy.ps_name}.${policy.policy_arn}" => policy
  }

  # Excludes all permission sets without inline policies
  inline_policies_map = { for name, value in var.permission_sets : name => concat(value.inline_policies, value.eks_access ? [data.aws_iam_policy_document.eks_viewer.json] : []) if length(value.inline_policies) > 0 || value.eks_access }
}

resource "aws_ssoadmin_permission_set" "this" {
  for_each         = var.permission_sets
  name             = each.key
  description      = each.value.description
  instance_arn     = var.sso_instance_arn
  session_duration = try(each.value.session_duration, var.default_ps_session_duration)
}

# Since a permission set can only have a single inline policy,
# this combines all provided policies into one
data "aws_iam_policy_document" "combined" {
  for_each                = local.inline_policies_map
  source_policy_documents = each.value
}

resource "aws_ssoadmin_permission_set_inline_policy" "this" {
  for_each           = local.inline_policies_map
  inline_policy      = data.aws_iam_policy_document.combined[each.key].json
  instance_arn       = var.sso_instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.this[each.key].arn
}

resource "aws_ssoadmin_managed_policy_attachment" "this" {
  for_each           = local.managed_policy_attachments_map
  instance_arn       = var.sso_instance_arn
  managed_policy_arn = each.value.policy_arn
  permission_set_arn = aws_ssoadmin_permission_set.this[each.value.ps_name].arn
}
