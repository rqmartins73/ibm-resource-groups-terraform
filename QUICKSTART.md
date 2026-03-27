# Quick Start Guide

This guide will help you quickly deploy IBM Cloud Resource Groups using this Terraform configuration.

## Prerequisites

- IBM Cloud account
- IBM Cloud API Key ([Create one here](https://cloud.ibm.com/iam/apikeys))
- Terraform >= 1.3.0 (for local deployment) OR IBM Cloud Schematics access

## Option 1: Deploy with IBM Cloud Schematics (Recommended)

### Step 1: Create a Schematics Workspace

1. Log in to [IBM Cloud Console](https://cloud.ibm.com)
2. Navigate to **Schematics** > **Workspaces**
3. Click **Create workspace**

### Step 2: Configure the Workspace

- **Workspace name**: `resource-groups-workspace`
- **Resource group**: Select your resource group
- **Location**: Choose a location (e.g., `us-south`)
- **Description**: "Terraform workspace for managing resource groups"

### Step 3: Connect to Repository

- **Repository URL**: Enter your Git repository URL
- **Personal access token**: (if private repository)
- **Terraform version**: Select `terraform_v1.3` or higher

### Step 4: Set Variables

In the workspace, go to **Settings** and add these variables:

| Variable Name | Type | Value | Sensitive |
|---------------|------|-------|-----------|
| `ibmcloud_api_key` | string | Your IBM Cloud API Key | ✓ Yes |
| `region` | string | `us-south` | No |
| `resource_groups` | list | See example below | No |

**Example resource_groups value:**
```json
[
  {
    "name": "dev-resource-group",
    "tags": ["environment:dev", "managed-by:terraform"]
  },
  {
    "name": "prod-resource-group",
    "tags": ["environment:prod", "managed-by:terraform"]
  }
]
```

### Step 5: Generate and Apply Plan

1. Click **Generate plan**
2. Review the plan output
3. Click **Apply plan** to create the resource groups
4. Monitor the apply logs

### Step 6: View Outputs

After successful apply, view the outputs in the **Outputs** tab to see:
- Resource group IDs
- Resource group CRNs
- Summary information

---

## Option 2: Deploy Locally with Terraform CLI

### Step 1: Clone the Repository

```bash
git clone <repository-url>
cd ibm-resource-groups-terraform
```

### Step 2: Create Variables File

```bash
cp terraform.tfvars.example terraform.tfvars
```

### Step 3: Edit terraform.tfvars

```bash
# Use your preferred editor
nano terraform.tfvars
# or
code terraform.tfvars
```

Add your configuration:
```hcl
ibmcloud_api_key = "your-api-key-here"
region = "us-south"

resource_groups = [
  {
    name = "dev-resource-group"
    tags = ["environment:dev"]
  },
  {
    name = "prod-resource-group"
    tags = ["environment:prod"]
  }
]
```

### Step 4: Initialize Terraform

```bash
terraform init
```

### Step 5: Plan the Deployment

```bash
terraform plan
```

Review the planned changes carefully.

### Step 6: Apply the Configuration

```bash
terraform apply
```

Type `yes` when prompted to confirm.

### Step 7: View Outputs

```bash
terraform output
```

---

## Common Use Cases

### Use Case 1: Create Resource Groups for Multiple Environments

```hcl
resource_groups = [
  {
    name = "project-dev"
    tags = ["environment:dev", "project:myapp"]
  },
  {
    name = "project-test"
    tags = ["environment:test", "project:myapp"]
  },
  {
    name = "project-stage"
    tags = ["environment:stage", "project:myapp"]
  },
  {
    name = "project-prod"
    tags = ["environment:prod", "project:myapp"]
  }
]
```

### Use Case 2: Create Resource Groups for Multiple Teams

```hcl
resource_groups = [
  {
    name = "team-alpha-resources"
    tags = ["team:alpha", "department:engineering"]
  },
  {
    name = "team-beta-resources"
    tags = ["team:beta", "department:engineering"]
  },
  {
    name = "team-gamma-resources"
    tags = ["team:gamma", "department:data-science"]
  }
]
```

### Use Case 3: Bulk Creation for Multi-Project Setup

```hcl
resource_groups = [
  {
    name = "webapp-frontend-dev"
    tags = ["project:webapp", "component:frontend", "env:dev"]
  },
  {
    name = "webapp-backend-dev"
    tags = ["project:webapp", "component:backend", "env:dev"]
  },
  {
    name = "webapp-database-dev"
    tags = ["project:webapp", "component:database", "env:dev"]
  },
  {
    name = "webapp-frontend-prod"
    tags = ["project:webapp", "component:frontend", "env:prod"]
  },
  {
    name = "webapp-backend-prod"
    tags = ["project:webapp", "component:backend", "env:prod"]
  },
  {
    name = "webapp-database-prod"
    tags = ["project:webapp", "component:database", "env:prod"]
  }
]
```

---

## Verification

After deployment, verify your resource groups:

### Using IBM Cloud CLI

```bash
# List all resource groups
ibmcloud resource groups

# Get details of a specific resource group
ibmcloud resource group <resource-group-name>
```

### Using IBM Cloud Console

1. Navigate to **Manage** > **Account** > **Resource groups**
2. Verify your newly created resource groups appear in the list

---

## Cleanup

### Using Schematics

1. Go to your workspace
2. Click **Actions** > **Destroy resources**
3. Confirm the destruction

### Using Terraform CLI

```bash
terraform destroy
```

Type `yes` when prompted.

---

## Troubleshooting

### Issue: Authentication Failed

**Solution**: Verify your API key is correct and has the necessary permissions.

```bash
# Test your API key
ibmcloud login --apikey <your-api-key>
```

### Issue: Resource Group Already Exists

**Solution**: Resource group names must be unique. Choose a different name or import the existing resource group.

```bash
# Import existing resource group
terraform import 'ibm_resource_group.resource_groups["existing-name"]' <resource-group-id>
```

### Issue: Permission Denied

**Solution**: Ensure your API key has the following IAM permissions:
- Viewer role on All Account Management services
- Editor role on All Resource Groups

---

## Next Steps

After creating resource groups:

1. **Assign Access Policies**: Configure IAM policies for users and service IDs
2. **Create Resources**: Deploy resources into your new resource groups
3. **Set Up Cost Tracking**: Use tags for cost allocation and tracking
4. **Implement Governance**: Apply resource group-level policies

---

## Support

For issues or questions:
- Review the [main README](README.md)
- Check [IBM Cloud Documentation](https://cloud.ibm.com/docs)
- Open an issue in this repository