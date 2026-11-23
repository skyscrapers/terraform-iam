locals {
  group_assignments = flatten([
    for ps_name, value in var.permission_sets : [
      for id in value.account_ids : {
        ps_name    = ps_name
        account_id = id
        group_name = value.group
      }
    ]
  ])
  group_assignments_map = {
    for assignment in local.group_assignments : "${assignment.ps_name}.${assignment.account_id}" => assignment
  }
}

resource "aws_ssoadmin_account_assignment" "this" {
  for_each = local.group_assignments_map

  instance_arn       = var.sso_instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.this[each.value.ps_name].arn

  principal_id   = var.group_ids[each.value.group_name]
  principal_type = "GROUP"

  target_id   = each.value.account_id
  target_type = "AWS_ACCOUNT"
}
