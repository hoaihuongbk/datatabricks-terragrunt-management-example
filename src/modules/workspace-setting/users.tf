data "databricks_group" "admins" {
  for_each     = toset(var.admin_groups)
  provider     = databricks.mws
  display_name = each.value
}

resource "databricks_mws_permission_assignment" "add_admins_group" {
  for_each     = toset(var.admin_groups)
  provider     = databricks.mws
  workspace_id = var.workspace_number_id
  principal_id = data.databricks_group.admins[each.key].id
  permissions  = ["ADMIN"]
}

data "databricks_group" "users" {
  for_each     = toset(var.user_groups)
  provider     = databricks.mws
  display_name = each.value
}

resource "databricks_mws_permission_assignment" "add_users_group" {
  for_each     = toset(var.user_groups)
  provider     = databricks.mws
  workspace_id = var.workspace_number_id
  principal_id = data.databricks_group.users[each.key].id
  permissions  = ["USER"]
}