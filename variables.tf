##############################################################################
# IBM Cloud Resource Groups - Variable Definitions
#
# This file defines all input variables for the resource group configuration
##############################################################################

##############################################################################
# Account Variables
##############################################################################

variable "ibmcloud_api_key" {
  description = "IBM Cloud API Key for authentication. This key must have permissions to create resource groups."
  type        = string
  sensitive   = true

  validation {
    condition     = length(var.ibmcloud_api_key) > 0
    error_message = "The IBM Cloud API key must not be empty."
  }
}

variable "region" {
  description = "IBM Cloud region where resources will be managed. This is primarily for provider configuration."
  type        = string
  default     = "us-south"

  validation {
    condition = contains([
      "us-south", "us-east", "eu-gb", "eu-de", "jp-tok", "jp-osa",
      "au-syd", "ca-tor", "br-sao", "eu-es"
    ], var.region)
    error_message = "Region must be a valid IBM Cloud region."
  }
}

##############################################################################
# Resource Group Variables
##############################################################################

variable "resource_groups" {
  description = <<-EOT
    List of resource groups to create. Each resource group should be defined as an object with the following attributes:
    - name (required): Unique name for the resource group
    - tags (optional): List of tags to apply to the resource group for organization and cost tracking
    - quota_id (optional): ID of the quota to apply to the resource group
    
    Example:
    resource_groups = [
      {
        name = "dev-resource-group"
        tags = ["environment:dev", "team:engineering", "project:webapp"]
      },
      {
        name = "prod-resource-group"
        tags = ["environment:prod", "team:engineering", "project:webapp"]
      },
      {
        name = "test-resource-group"
        tags = ["environment:test", "team:qa"]
      }
    ]
  EOT

  type = list(object({
    name     = string
    tags     = optional(list(string), [])
    quota_id = optional(string, null)
  }))

  default = [
    {
      name = "powervs",
      tags = ["environment:powervs"]
    },
    {
      name = "vpc",
      tags = ["environment:vpc"]
    },
    {
      name = "cos",
      tags = ["environment:cos"]
    },
    {
      name = "log",
      tags = ["environment:log"]
    }
  ]

  validation {
    condition     = length(var.resource_groups) > 0
    error_message = "At least one resource group must be defined."
  }

  validation {
    condition = alltrue([
      for rg in var.resource_groups : length(rg.name) > 0 && length(rg.name) <= 40
    ])
    error_message = "Resource group names must be between 1 and 40 characters."
  }

  validation {
    condition = alltrue([
      for rg in var.resource_groups : can(regex("^[a-zA-Z0-9-_]+$", rg.name))
    ])
    error_message = "Resource group names can only contain alphanumeric characters, hyphens, and underscores."
  }

  validation {
    condition = length(var.resource_groups) == length(distinct([
      for rg in var.resource_groups : rg.name
    ]))
    error_message = "Resource group names must be unique within the list."
  }
}

##############################################################################
# Optional Configuration Variables
##############################################################################

variable "tags" {
  description = "Global tags to apply to all resource groups in addition to individual tags. Useful for organization-wide tagging policies."
  type        = list(string)
  default     = []

  validation {
    condition = alltrue([
      for tag in var.tags : can(regex("^[a-zA-Z0-9:_-]+$", tag))
    ])
    error_message = "Tags must contain only alphanumeric characters, colons, hyphens, and underscores."
  }
}