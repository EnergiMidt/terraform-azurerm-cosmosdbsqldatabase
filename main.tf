locals {
  name = var.override_name == null ? "${var.system_name}-${lower(var.environment)}-sqldb" : var.override_name

  cosmosdb_sql_database = concat(azurerm_cosmosdb_sql_database.cosmosdb_sql_database.*, [null])[0]
  enable_serverless     = contains(var.cosmosdb_account.capabilities[*].name, "EnableServerless")
}

resource "azurerm_cosmosdb_sql_database" "cosmosdb_sql_database" {
  name                = local.name
  resource_group_name = var.resource_group.name

  account_name = var.cosmosdb_account.name

  # (Optional) The throughput of SQL database (RU/s). Must be set in increments of 100.
  # The minimum value is 400.
  # This must be set upon database creation otherwise it cannot be updated without a manual terraform destroy-apply.
  # Do not set when azurerm_cosmosdb_account is configured with EnableServerless capability.
  throughput = var.enable_autoscale_settings == false && local.enable_serverless == false ? var.throughput : null

  # (Optional) An autoscale_settings block as defined below.
  # This must be set upon database creation otherwise it cannot be updated without a manual terraform destroy-apply.
  dynamic "autoscale_settings" {
    for_each = var.enable_autoscale_settings == true && local.enable_serverless == false ? [1] : []
    content {
      max_throughput = var.autoscale_settings_max_throughput
    }
  }
}
