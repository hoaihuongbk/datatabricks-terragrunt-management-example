resource "databricks_workspace_conf" "default" {
  provider = databricks.workspace
  custom_config = {
    "enableIpAccessLists" : true
    "enableDeprecatedClusterNamedInitScripts" : false
  }
}

resource "databricks_ip_access_list" "allowed-list" {
  count        = length(var.whitelisted_ips) > 0 ? 1 : 0
  provider     = databricks.workspace
  label        = "allow-in"
  list_type    = "ALLOW"
  ip_addresses = var.whitelisted_ips
}
