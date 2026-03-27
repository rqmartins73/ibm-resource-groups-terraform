##############################################################################
# IBM Cloud Resource Groups - Terraform and Provider Version Constraints
#
# This file defines the required Terraform version and provider versions
# to ensure compatibility and stability
##############################################################################

terraform {
  ##############################################################################
  # Terraform Version Constraint
  ##############################################################################
  
  required_version = ">= 1.3.0"

  ##############################################################################
  # Required Providers
  ##############################################################################
  
  required_providers {
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = ">= 1.60.0"
    }
  }

  ##############################################################################
  # Backend Configuration (Optional)
  ##############################################################################
  
  # Uncomment and configure for remote state storage
  # This is recommended for team collaboration and IBM Cloud Schematics
  
  # backend "s3" {
  #   # IBM Cloud Object Storage backend configuration
  #   bucket                      = "your-terraform-state-bucket"
  #   key                         = "resource-groups/terraform.tfstate"
  #   region                      = "us-south"
  #   endpoint                    = "s3.us-south.cloud-object-storage.appdomain.cloud"
  #   skip_credentials_validation = true
  #   skip_region_validation      = true
  #   skip_requesting_account_id  = true
  # }

  # For IBM Cloud Schematics, the backend is automatically configured
  # No backend configuration is needed when using Schematics
}

##############################################################################
# Provider Configuration Notes
##############################################################################

# The IBM Cloud provider is configured in main.tf with the following parameters:
# - ibmcloud_api_key: Authentication key for IBM Cloud
# - region: Target region for API calls
#
# Additional provider configuration options:
# - ibmcloud_timeout: Timeout for API calls (default: 60 seconds)
# - max_retries: Maximum number of retries for API calls (default: 5)
# - generation: VPC generation (1 or 2, default: 2)
#
# Example advanced provider configuration (add to main.tf if needed):
# provider "ibm" {
#   ibmcloud_api_key = var.ibmcloud_api_key
#   region           = var.region
#   ibmcloud_timeout = 120
#   max_retries      = 10
# }