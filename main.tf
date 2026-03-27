##############################################################################
# IBM Cloud Resource Groups - Main Configuration
#
# This configuration creates multiple IBM Cloud Resource Groups based on
# the input variable list. Each resource group can have custom tags.
##############################################################################

##############################################################################
# IBM Cloud Provider Configuration
##############################################################################

provider "ibm" {
  ibmcloud_api_key = var.ibmcloud_api_key
  region           = var.region
}

##############################################################################
# Create Resource Groups
##############################################################################

resource "ibm_resource_group" "resource_groups" {
  for_each = { for rg in var.resource_groups : rg.name => rg }

  name  = each.value.name
  tags  = lookup(each.value, "tags", [])
  quota_id = lookup(each.value, "quota_id", null)
}

##############################################################################
# Data Sources - Fetch existing resource groups for reference
##############################################################################

data "ibm_resource_group" "created_groups" {
  for_each = ibm_resource_group.resource_groups

  name = each.value.name

  depends_on = [ibm_resource_group.resource_groups]
}