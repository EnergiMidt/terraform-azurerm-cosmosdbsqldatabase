# [azurerm_cosmosdb_sql_database][1]

Manages a SQL Database within a Cosmos DB Account.

## Getting Started

- Format and validate Terraform code before commit.

```shell
terraform init -upgrade \
    && terraform init -reconfigure -upgrade \
    && terraform fmt -recursive . \
    && terraform fmt -check \
    && terraform validate .
```

- Always fetch latest changes from upstream and rebase from it. Terraform documentation will always be updated with GitHub Actions. See also [.github/workflows/terraform.yml](.github/workflows/terraform.yml) GitHub Actions workflow.

```shell
git fetch --all --tags --prune --prune-tags \
  && git pull --rebase --all --prune --tags
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.1 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.33.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.33.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_cosmosdb_sql_database.cosmosdb_sql_database](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_sql_database) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_autoscale_settings_max_throughput"></a> [autoscale\_settings\_max\_throughput](#input\_autoscale\_settings\_max\_throughput) | (Optional) The maximum throughput of the SQL database (RU/s). Must be between `1,000` and `1,000,000`. Must be set in increments of `1,000`. Conflicts with `throughput`. | `number` | `"1000"` | no |
| <a name="input_cosmosdb_account"></a> [cosmosdb\_account](#input\_cosmosdb\_account) | (Required) The CosmosDB (formally DocumentDB) Account. | `any` | n/a | yes |
| <a name="input_enable_autoscale_settings"></a> [enable\_autoscale\_settings](#input\_enable\_autoscale\_settings) | (Optional) Enable autoscale settings. This must be set upon database creation otherwise it cannot be updated without a manual terraform destroy-apply. | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Required) The name of the environment. | `string` | n/a | yes |
| <a name="input_override_name"></a> [override\_name](#input\_override\_name) | (Optional) Override the name of the resource. Under normal circumstances, it should not be used. | `string` | `null` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | (Required) The resource group in which to create the resource. | `any` | n/a | yes |
| <a name="input_system_name"></a> [system\_name](#input\_system\_name) | (Required) The systen name which should be used for this resource. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_throughput"></a> [throughput](#input\_throughput) | (Optional) The throughput of SQL database (RU/s). Must be set in increments of `100`. The minimum value is `400`. This must be set upon database creation otherwise it cannot be updated without a manual terraform destroy-apply. Do not set when `azurerm_cosmosdb_account` is configured with `EnableServerless` capability. Throughput has a maximum value of `1000000` unless a higher limit is requested via Azure Support. | `number` | `400` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cosmosdb_sql_database"></a> [cosmosdb\_sql\_database](#output\_cosmosdb\_sql\_database) | The Azure CosmosDB SQL Database resource. |
<!-- END_TF_DOCS -->

[1]: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_sql_database
