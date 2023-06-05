variable "name" {
  type        = string
  description = "Name of the variable within the workspace"
}

variable "project_id" {
  type        = string
  description = "ID of the Project to assign the workspace to"
  default     = null
}

variable "organization" {
  type        = string
  description = "Name of the organisation to deploy the workspace to"
}

variable "workspace_tags" {
  type        = list(any)
  default     = []
  description = "List of tags to be assigned to the workspace"
}

variable "tfe_variables" {
  description = "Map of variable configuration. All variables need to be of the same type or it will error. My best recommendation is to convert to string type and revert to the desired type in the destination module"
  type = map(object(
    {
      key         = optional(string)
      value       = optional(string)
      description = optional(string)
      category    = optional(string)
      hcl         = optional(string)
      sensitive   = optional(bool) // it is a general recommendation to not deploy sensitive variables using terraform 
  }))
  default = {}
}

variable "vcs_repo" {
  type        = list(any)
  default     = []
  description = "VCS_Repo configuration parameters"
}

variable "structured_run_output_enabled" {
  type    = string
  default = false
}

variable "sentinel_policy" {
  type        = list(string)
  default     = []
  description = "List of Sentinel Policy Sets to apply to this workspace"
}