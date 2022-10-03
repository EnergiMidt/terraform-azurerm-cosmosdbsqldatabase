output "cosmosdb_sql_database" {
  description = "The Azure CosmosDB SQL Database resource."
  value       = local.cosmosdb_sql_database
}
output "cosmosdb_sql_database_name" {
  description = "The name of Azure CosmosDB SQL Database resource."
  value       = local.name
}
