# IBM Cloud Resource Groups - Terraform Module

This Terraform configuration allows you to create multiple IBM Cloud Resource Groups in bulk using IBM Cloud Schematics.

## Overview

Resource Groups in IBM Cloud are logical containers that help you organize and manage your cloud resources. This module enables you to create multiple resource groups efficiently.

## Prerequisites

- IBM Cloud account
- IBM Cloud API Key with appropriate permissions
- Access to IBM Cloud Schematics (optional, but recommended)

## Features

- Create multiple resource groups in a single deployment
- Configurable resource group names and tags
- Compatible with IBM Cloud Schematics
- Support for quota management
- Outputs for easy reference of created resource groups

## Usage

### Basic Example

```hcl
resource_groups = [
  {
    name = "dev-resource-group"
    tags = ["environment:dev", "team:engineering"]
  },
  {
    name = "prod-resource-group"
    tags = ["environment:prod", "team:engineering"]
  }
]
```

### Using with IBM Cloud Schematics

1. **Create a Schematics Workspace:**
   - Navigate to IBM Cloud Schematics
   - Create a new workspace
   - Point to this repository

2. **Configure Variables:**
   - Set your `ibmcloud_api_key`
   - Define your `resource_groups` list
   - Optionally set `region`

3. **Generate and Apply Plan:**
   - Generate the Terraform plan
   - Review the changes
   - Apply to create the resource groups

### Local Development

1. Clone this repository:
```bash
git clone <repository-url>
cd ibm-resource-groups-terraform
```

2. Create a `terraform.tfvars` file (see `terraform.tfvars.example`):
```bash
cp terraform.tfvars.example terraform.tfvars
```

3. Edit `terraform.tfvars` with your values:
```hcl
ibmcloud_api_key = "your-api-key-here"
resource_groups = [
  {
    name = "my-resource-group-1"
    tags = ["env:dev"]
  },
  {
    name = "my-resource-group-2"
    tags = ["env:prod"]
  }
]
```

4. Initialize and apply:
```bash
terraform init
terraform plan
terraform apply
```

## Input Variables

| Name | Description | Type | Required | Default |
|------|-------------|------|----------|---------|
| `ibmcloud_api_key` | IBM Cloud API Key | string | Yes | - |
| `resource_groups` | List of resource groups to create | list(object) | Yes | - |
| `region` | IBM Cloud region | string | No | "us-south" |

### Resource Group Object Structure

Each resource group object should contain:
- `name` (required): Name of the resource group
- `tags` (optional): List of tags to apply to the resource group

## Outputs

| Name | Description |
|------|-------------|
| `resource_group_ids` | Map of resource group names to their IDs |
| `resource_group_details` | Complete details of all created resource groups |

## File Structure

```
ibm-resource-groups-terraform/
├── README.md                    # This file
├── main.tf                      # Main Terraform configuration
├── variables.tf                 # Variable definitions
├── outputs.tf                   # Output definitions
├── versions.tf                  # Provider version constraints
├── terraform.tfvars.example     # Example variables file
└── .gitignore                   # Git ignore file
```

## Best Practices

1. **Naming Convention**: Use descriptive names for resource groups (e.g., `project-environment-purpose`)
2. **Tagging Strategy**: Apply consistent tags for better organization and cost tracking
3. **API Key Security**: Never commit your API key to version control
4. **Resource Group Limits**: Be aware of IBM Cloud account limits on resource groups

## Troubleshooting

### Common Issues

1. **Authentication Error**: Ensure your API key has the correct permissions
2. **Duplicate Names**: Resource group names must be unique within your account
3. **Quota Exceeded**: Check your account's resource group quota

## Contributing

Contributions are welcome! Please follow these steps:
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## License

This project is licensed under the Apache License 2.0.

## Support

For issues and questions:
- Open an issue in this repository
- Consult [IBM Cloud Documentation](https://cloud.ibm.com/docs)
- Contact IBM Cloud Support

## Additional Resources

- [IBM Cloud Resource Groups Documentation](https://cloud.ibm.com/docs/account?topic=account-rgs)
- [IBM Cloud Schematics Documentation](https://cloud.ibm.com/docs/schematics)
- [Terraform IBM Cloud Provider](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs)