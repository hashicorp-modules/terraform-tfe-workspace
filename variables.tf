variable "tfe_token"     {}
variable "tfe_org_name"  {}
variable "tfe_org_email" {}
variable "tfe_org_id"    { default = "" }

variable "tfe_producer_name"        { default = "tfe-workspace-producer" }
variable "tfe_producer_team_id"     { default = "" }
variable "tfe_producer_team_access" { default = "admin" }
variable "tfe_consumer_name"        { default = "tfe-workspace-consumer" }
variable "tfe_consumer_team_id"     { default = "" }
variable "tfe_consumer_team_access" { default = "read" }

# variable "vcs_repo_identifier" { default = "hashicorp-modules/terraform-tfe-workspace" }
variable "vcs_repo_identifier" { default = "hashicorp/terraform-guides" }
variable "vcs_repo_branch"     { default = "master" }
variable "working_directory"   { default = "./" }
