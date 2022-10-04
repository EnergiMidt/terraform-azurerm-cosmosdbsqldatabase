variable "environment" {
  description = "(Required) The name of the environment."
  type        = string
  validation {
    condition = contains([
      "dev",
      "test",
      "prod",
    ], var.environment)
    error_message = "Possible values are dev, test, and prod."
  }
}

# This `name` variable is replaced by the use of `system_name` and `environment` variables.
# variable "name" {
#   description = "(Required) The name which should be used for this resource. Changing this forces a new resource to be created."
#   type        = string
# }

variable "system_name" {
  description = "(Required) The systen name which should be used for this resource. Changing this forces a new resource to be created."
  type        = string
}

variable "override_name" {
  description = "(Optional) Override the name of the resource. Under normal circumstances, it should not be used."
  default     = null
  type        = string
}

# This `override_location` variable is not applicable in this resource.
# variable "override_location" {
#   description = "(Optional) Override the location of the resource. Under normal circumstances, it should not be used."
#   default     = null
#   type        = string
# }

variable "resource_group" {
  description = "(Required) The resource group in which to create the resource."
  type        = any
}

# This `resource_group_name` variable is replaced by the use of `resource_group` variable.
# variable "resource_group_name" {
#   description = "(Required) The name of the resource group where the resource should exist. Changing this forces a new resource to be created."
#   type        = string
# }

# This `location` variable is replaced by the use of `resource_group` variable.
# variable "location" {
#   description = "(Required) The location where the resource should exist. Changing this forces a new resource to be created."
#   type        = string
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
