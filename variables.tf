variable "tfe_token" {
  description = "Token from the TFE account for the TFE provider API access"
}

variable "tfe_org_name" {
  description = "Name of organization to be created in TFE."
}

variable "tfe_org_email" {
  description = "Email for organziation to be created in TFE."
}

variable "tfe_org_id" {
  default     = ""
  description = "ID of organization in TFE to use, if empty, an organization will be created."
}

variable "tfe_producer_name" {
  default     = "tfe-workspace-producer"
  description = "Name of the \"Producer\" workspace and team."
}

variable "tfe_producer_team_id" {
  default     = ""
  description = "ID of \"Producer\" team in TFE to use, if empty, a team will be created"
}

variable "tfe_producer_team_access" {
  default     = "admin"
  description = "Access level for the \"Producer\" team, defaults to \"admin\""
}

variable "tfe_consumer_name" {
  default     = "tfe-workspace-consumer"
  description = "Name of the \"Consumer\" team, defaults to \"tfe-workspace-consumer\""
}

variable "tfe_consumer_team_id" {
  default     = ""
  description = "ID of \"Consumer\" team in TFE to use, if empty, a team will be created"
}

variable "tfe_consumer_team_access" {
  default     = "read"
  description = "Access level for the \"Consumer\" team"
}

variable "vcs_repo_identifier" {
  default     = "hashicorp-modules/terraform-tfe-workspace"
  description = "Org and repo name for VCS, defaults to `hashicorp-modules/terraform-tfe-workspace`"
}

variable "vcs_repo_branch" {
  default     = "master"
  description = "Github branch name"
}

variable "working_directory" {
  default     = "./"
  description = "Working directory for Terraform to run in, defaults to the root directory"
}
