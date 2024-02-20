locals {
  logic_app = {
    logic_app_action_custom                        = try(var.logic_app.logic_app_action_custom, {})
    logic_app_action_http                          = try(var.logic_app.logic_app_action_http, {})
    logic_app_integration_account                  = try(var.logic_app.logic_app_integration_account, {})
    logic_app_trigger_custom                       = try(var.logic_app.logic_app_trigger_custom, {})
    logic_app_trigger_http_request                 = try(var.logic_app.logic_app_trigger_http_request, {})
    logic_app_trigger_recurrence                   = try(var.logic_app.logic_app_trigger_recurrence, {})
    logic_app_workflow                             = try(var.logic_app.logic_app_workflow, {})
    logic_app_standard                             = try(var.logic_app.logic_app_standard, {})
    # logic_app_integration_account                  = try(local.combined_objects_logic_app_integration_account, null)
    # logic_app_workflow                             = try(local.combined_objects_logic_app_workflow, null)
    # logic_app_standard                             = try(local.combined_objects_logic_app_standard, null)
    # combined_objects_logic_app_integration_account = merge(tomap({ (local.client_config.landingzone_key) = module.logic_app_integration_account }), try(var.remote_objects.logic_app_integration_account, {}), try(var.data_sources.logic_app_integration_account, {}))
    # combined_objects_logic_app_standard            = merge(tomap({ (local.client_config.landingzone_key) = module.logic_app_standard }), try(var.remote_objects.logic_app_standard, {}))
    # combined_objects_logic_app_workflow            = merge(tomap({ (local.client_config.landingzone_key) = module.logic_app_workflow }), try(var.remote_objects.logic_app_workflow, {}), try(var.data_sources.logic_app_workflow, {}))
  }
}