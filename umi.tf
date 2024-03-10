// User assigned Managed Identity
//**********************************************************************************************
resource "azurerm_user_assigned_identity" "user_assigned_identity" {
  for_each = { for identity in var.identities : identity.name => identity }
  resource_group_name = each.value.resource_group_name
  location            = each.value.location

  name = "${each.key}_Identity"

  tags       = each.value.tags
  depends_on = [var.it_depends_on]

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }

  timeouts {
    create = local.timeout_duration
    delete = local.timeout_duration
  }
}
//**********************************************************************************************


// Role assignment to Managed Identity
//**********************************************************************************************
resource "azurerm_role_assignment" "role_assignment" {
  for_each             = var.role_assignment
  scope                = each.value.scope
  principal_id         = azurerm_user_assigned_identity.user_assigned_identity.principal_id
  role_definition_name = each.value.role_definition_name
  role_definition_id   = each.value.role_definition_id
}
//**********************************************************************************************

variable "identities" {
  description = "identity configuration"
  type = list(object({
    name                = string
    location            = string
    resource_group_name = string
    tags                = map(any)
  }))
}

// Optional Variables
//**********************************************************************************************
variable "role_assignment" {
  type = map(object({
    scope                = string #(Required) The scope at which the Role Assignment applies to
    role_definition_id   = string #(Optional) The Scoped-ID of the Role Definition
    role_definition_name = string #(Optional) The name of a built-in Role. Changing this forces a new resource to be created
  }))
  description = "(Optional) Arguments required to assign roles to managed identity"
  default     = {}
}

variable "identity_prefix" {
  type        = string
  description = "(Optional) Prefix for Postgresql server name"
  default     = ""
}

variable "identity_suffix" {
  type        = string
  description = "(Optional) Suffix for AKS cluster name"
  default     = ""
}

variable "resource_tags" {
  type        = map(string)
  description = "(Optional) Tags for resources"
  default     = {}
}
variable "deployment_tags" {
  type        = map(string)
  description = "(Optional) Tags for deployment"
  default     = {}
}
variable "it_depends_on" {
  type        = any
  description = "(Optional) To define explicit dependencies if required"
  default     = null
}
//**********************************************************************************************


// Local Values
//**********************************************************************************************
locals {
  timeout_duration = "1h"
  identity_name    = "${var.identity_prefix}${var.name}${var.identity_suffix}"
}
//**********************************************************************************************