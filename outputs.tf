##############################################################################
# IBM Cloud Resource Groups - Output Definitions
#
# This file defines outputs that provide information about created resources
##############################################################################

##############################################################################
# Resource Group Outputs
##############################################################################

output "resource_group_ids" {
  description = "Map of resource group names to their IDs. Use these IDs when creating resources in specific resource groups."
  value = {
    for name, rg in ibm_resource_group.resource_groups : name => rg.id
  }
}

output "resource_group_crns" {
  description = "Map of resource group names to their Cloud Resource Names (CRNs). CRNs are globally unique identifiers."
  value = {
    for name, rg in ibm_resource_group.resource_groups : name => rg.crn
  }
}

output "resource_group_details" {
  description = "Complete details of all created resource groups including ID, CRN, state, and tags."
  value = {
    for name, rg in ibm_resource_group.resource_groups : name => {
      id         = rg.id
      crn        = rg.crn
      name       = rg.name
      state      = rg.state
      tags       = rg.tags
      created_at = rg.created_at
      updated_at = rg.updated_at
    }
  }
}

output "resource_group_names" {
  description = "List of all created resource group names."
  value       = [for rg in ibm_resource_group.resource_groups : rg.name]
}

output "resource_group_count" {
  description = "Total number of resource groups created."
  value       = length(ibm_resource_group.resource_groups)
}

##############################################################################
# Summary Output
##############################################################################

output "summary" {
  description = "Summary of the resource group deployment including count and names."
  value = {
    total_resource_groups = length(ibm_resource_group.resource_groups)
    resource_group_names  = [for rg in ibm_resource_group.resource_groups : rg.name]
    region                = var.region
    deployment_timestamp  = timestamp()
  }
}

##############################################################################
# Outputs for Integration with Other Modules
##############################################################################

output "resource_group_map" {
  description = "Map of resource group names to complete resource group objects. Useful for module composition."
  value       = ibm_resource_group.resource_groups
}

output "resource_group_ids_list" {
  description = "List of all resource group IDs in the order they were created."
  value       = [for rg in ibm_resource_group.resource_groups : rg.id]
}