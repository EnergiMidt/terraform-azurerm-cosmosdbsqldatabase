variable "name" {
  description = "(Required) The name of the CosmosDB SQL database."
  type        = string
}

variable "override_name" {
  description = "(Optional) Override the name of the resource. Under normal circumstances, it should not be used."
  default     = ""
  type        = string
}

variable "environment" {
  description = "(Required) The name of the environment."
  type        = string
  validation {
    condition = contains([
      "dev",
      "test",
      "prod",
    ], var.environment)
    error_message = "Valid options are dev, test, and prod."
  }
}

variable "resource_group" {
  description = "(Required) The name of the resource group in which the CosmosDB Account is created. Changing this forces a new resource to be created."
  type        = any
}

# This `resource_group_name` variable is replaced by the use of `resource_group` variable.
# variable "resource_group_name" {
#   description = "(Required) The name of the resource group in which the Log Analytics workspace is created. Changing this forces a new resource to be created."
#   type        = string
# }

# This `location` variable is replaced by the use of `resource_group` variable.
# variable "location" {
#   description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
#   type        = string
# }

# variable "systemaccess_developer_group_id" {
#   description = "The object id of the Azure AD group systemaccess-<system>-developers. Gets read access to the Storage Account. To grant additional access, use azurerm_role_assignment."
#   default     = "00000000-0000-0000-0000-000000000000"
#   type        = string
#   validation {
#     condition     = can(regex("^[0-9a-fA-F]{8}\\b-[0-9a-fA-F]{4}\\b-[0-9a-fA-F]{4}\\b-[0-9a-fA-F]{4}\\b-[0-9a-fA-F]{12}$", var.systemaccess_developer_group_id))
#     error_message = "The systemaccess_developer_group_id value must be a valid globally unique identifier (GUID)."
#   }
# }

variable "cosmosdb_account" {
  description = "(Required) The CosmosDB (formally DocumentDB) Account."
  type        = any
}

# This `account_name` variable is replaced by the use of `cosmosdb_account` variable.
# variable "account_name" {
#   description = " (Required) The name of the Cosmos DB SQL Database to create the table within. Changing this forces a new resource to be created."
#   type        = string
# }

variable "throughput" {
  description = "(Optional) The throughput of SQL database (RU/s). Must be set in increments of `100`. The minimum value is `400`. This must be set upon database creation otherwise it cannot be updated without a manual terraform destroy-apply. Do not set when `azurerm_cosmosdb_account` is configured with `EnableServerless` capability. Throughput has a maximum value of `1000000` unless a higher limit is requested via Azure Support."
  default     = 400
  type        = number
  validation {
    # The regex(...) function fails if it cannot find a match.
    # https://regex101.com/r/sXJK96/1
    condition     = var.throughput >= 400 && var.throughput <= 1000000 && can(regex("^([4-9]|[0-9]\\d{1,3}|10000)00$", tostring(var.throughput)))
    error_message = "The throughput of SQL database (RU/s) must be set in increments of `100`. The minimum value is `400` and the maximum value of `1000000`."
  }
}

variable "enable_autoscale_settings" {
  description = "(Optional) Enable autoscale settings. This must be set upon database creation otherwise it cannot be updated without a manual terraform destroy-apply."
  default     = false
  type        = bool
}

variable "autoscale_settings_max_throughput" {
  description = "(Optional) The maximum throughput of the SQL database (RU/s). Must be between `1,000` and `1,000,000`. Must be set in increments of `1,000`. Conflicts with `throughput`."
  default     = "1000"
  type        = number
  validation {
    # The regex(...) function fails if it cannot find a match.
    # https://regex101.com/r/vemMsJ/1
    condition     = var.autoscale_settings_max_throughput >= 1000 && var.autoscale_settings_max_throughput <= 1000000 && can(regex("^([1-9]|[0-9]\\d{1,2}|1000)000$", tostring(var.autoscale_settings_max_throughput)))
    error_message = "The maximum throughput of the SQL database (RU/s) must be set in increments of `1000`. The minimum value is `1000` and the maximum value of `1000000`."
  }
}
