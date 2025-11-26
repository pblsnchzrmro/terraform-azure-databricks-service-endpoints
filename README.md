# terraform-azure-databricks-service-endpoints

## Development Setup

This project uses pre-commit hooks to ensure code quality and enforce commit message standards for semantic versioning.

### Prerequisites

Install pre-commit framework:

```bash
pip install pre-commit
```

### Initial Setup

After cloning the repository, install the git hooks:

```bash
# Install general pre-commit hooks (terraform formatting, validation, etc.)
pre-commit install

# Install commit message validation hook (required for semantic release)
pre-commit install --hook-type commit-msg
```

**Why two installation commands?**

Git supports different types of hooks that run at different stages:
- `pre-commit install` → Installs hooks that run **before** creating a commit (e.g., code formatting, linting)
- `pre-commit install --hook-type commit-msg` → Installs hooks that run **after** writing the commit message to validate its format

Both are required for this project to work correctly.

### Commit Message Format

This project follows [Conventional Commits](https://www.conventionalcommits.org/) specification for automated semantic versioning:

```
<type>(<scope>): <subject>

[optional body]

[optional footer]
```

**Allowed types:**
- `feat`: New feature (triggers minor version bump)
- `fix`: Bug fix (triggers patch version bump)
- `docs`: Documentation changes
- `style`: Code style changes (formatting, whitespace)
- `refactor`: Code refactoring without functionality changes
- `perf`: Performance improvements
- `test`: Adding or updating tests
- `build`: Build system or dependency changes
- `ci`: CI/CD configuration changes
- `chore`: Other changes that don't modify src or test files
- `revert`: Reverting a previous commit

**Examples:**
```bash
git commit -m "feat(storage): add firewall IP whitelist support"
git commit -m "fix(workspace): correct metastore assignment"
git commit -m "docs: update README with pre-commit instructions"
```

❌ **This will be rejected:**
```bash
git commit -m "updated files"
git commit -m "fix stuff"
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=4.31.0 |
| <a name="requirement_databricks"></a> [databricks](#requirement\_databricks) | >=1.81.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >=4.31.0 |
| <a name="provider_databricks.accounts"></a> [databricks.accounts](#provider\_databricks.accounts) | >=1.81.1 |
| <a name="provider_databricks.workspace"></a> [databricks.workspace](#provider\_databricks.workspace) | >=1.81.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_databricks_access_connector.storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/databricks_access_connector) | resource |
| [azurerm_databricks_access_connector.workspace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/databricks_access_connector) | resource |
| [azurerm_databricks_workspace.workspace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/databricks_workspace) | resource |
| [azurerm_network_security_group.nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.storage_blob_contributor](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_storage_account.adls](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_account_network_rules.adls](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account_network_rules) | resource |
| [azurerm_storage_container.data](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_subnet.private](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.public](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_network_security_group_association.private](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_network_security_group_association.public](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_user_assigned_identity.storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [databricks_external_location.external_location](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/external_location) | resource |
| [databricks_metastore_assignment.workspace](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/metastore_assignment) | resource |
| [databricks_mws_ncc_binding.ncc_binding](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/mws_ncc_binding) | resource |
| [databricks_mws_network_connectivity_config.ncc](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/mws_network_connectivity_config) | resource |
| [databricks_storage_credential.storage_credential](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/storage_credential) | resource |
| [databricks_metastore.metastore](https://registry.terraform.io/providers/databricks/databricks/latest/docs/data-sources/metastore) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_ips"></a> [allowed\_ips](#input\_allowed\_ips) | List of IP addresses allowed to bypass the storage account firewall | `list(string)` | `[]` | no |
| <a name="input_azure_region"></a> [azure\_region](#input\_azure\_region) | Azure region where resources will be deployed | `string` | n/a | yes |
| <a name="input_azure_subscription_id"></a> [azure\_subscription\_id](#input\_azure\_subscription\_id) | Azure subscription ID | `string` | n/a | yes |
| <a name="input_cidr_block"></a> [cidr\_block](#input\_cidr\_block) | VPC CIDR block range | `string` | `"10.20.0.0/23"` | no |
| <a name="input_databricks_account_host"></a> [databricks\_account\_host](#input\_databricks\_account\_host) | Databricks Account URL | `string` | n/a | yes |
| <a name="input_databricks_account_id"></a> [databricks\_account\_id](#input\_databricks\_account\_id) | Your Databricks Account ID | `string` | n/a | yes |
| <a name="input_databricks_metastore"></a> [databricks\_metastore](#input\_databricks\_metastore) | Databricks UC Metastore | `string` | n/a | yes |
| <a name="input_dbfs_storage_account"></a> [dbfs\_storage\_account](#input\_dbfs\_storage\_account) | Name of the storage account for DBFS | `string` | n/a | yes |
| <a name="input_default_storage_firewall_enabled"></a> [default\_storage\_firewall\_enabled](#input\_default\_storage\_firewall\_enabled) | Disallow public access to default storage account | `bool` | `true` | no |
| <a name="input_network_security_group_rules_required"></a> [network\_security\_group\_rules\_required](#input\_network\_security\_group\_rules\_required) | n/a | `string` | `"AllRules"` | no |
| <a name="input_private_subnets_cidr"></a> [private\_subnets\_cidr](#input\_private\_subnets\_cidr) | CIDR block for the private subnet | `string` | `"10.20.0.0/25"` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Project name used for resource naming | `string` | n/a | yes |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Allow public access to frontend workspace web UI | `bool` | `true` | no |
| <a name="input_public_subnets_cidr"></a> [public\_subnets\_cidr](#input\_public\_subnets\_cidr) | CIDR block for the public subnet | `string` | `"10.20.0.128/25"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_databricks_workspace_id"></a> [databricks\_workspace\_id](#output\_databricks\_workspace\_id) | ID of the Databricks workspace |
| <a name="output_databricks_workspace_url"></a> [databricks\_workspace\_url](#output\_databricks\_workspace\_url) | URL of the Databricks workspace |
| <a name="output_external_location_name"></a> [external\_location\_name](#output\_external\_location\_name) | Name of the Databricks external location |
| <a name="output_external_location_url"></a> [external\_location\_url](#output\_external\_location\_url) | URL of the Databricks external location |
| <a name="output_metastore_id"></a> [metastore\_id](#output\_metastore\_id) | ID of the Databricks metastore |
| <a name="output_ncc_id"></a> [ncc\_id](#output\_ncc\_id) | ID of the Network Connectivity Configuration |
| <a name="output_private_subnet_id"></a> [private\_subnet\_id](#output\_private\_subnet\_id) | ID of the private subnet |
| <a name="output_public_subnet_id"></a> [public\_subnet\_id](#output\_public\_subnet\_id) | ID of the public subnet |
| <a name="output_resource_group_id"></a> [resource\_group\_id](#output\_resource\_group\_id) | ID of the resource group |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | Name of the resource group |
| <a name="output_storage_account_id"></a> [storage\_account\_id](#output\_storage\_account\_id) | ID of the ADLS storage account |
| <a name="output_storage_account_name"></a> [storage\_account\_name](#output\_storage\_account\_name) | Name of the ADLS storage account |
| <a name="output_storage_container_name"></a> [storage\_container\_name](#output\_storage\_container\_name) | Name of the storage container |
| <a name="output_storage_credential_name"></a> [storage\_credential\_name](#output\_storage\_credential\_name) | Name of the Databricks storage credential |
| <a name="output_vnet_id"></a> [vnet\_id](#output\_vnet\_id) | ID of the virtual network |
<!-- END_TF_DOCS -->