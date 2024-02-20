variable "logic_app" {
  description = "Configuration object - Azure Logic App resources"
  default     = {}
}

variable "logic_app_workflow" {
  default = {}
}
variable "logic_app_standard" {
  default = {}
}
variable "logic_app_integration_account" {
  default = {}
}