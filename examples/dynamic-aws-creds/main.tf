variable "producer_name"       { default = "dynamic-aws-creds-producer" }
variable "consumer_name"       { default = "dynamic-aws-creds-consumer" }
variable "vcs_repo_identifier" { default = "hashicorp/terraform-guides" }
variable "vcs_repo_branch"     { default = "f-dynamic-aws-creds-tfe" }
variable "producer_wd"         { default = "infrastructure-as-code/dynamic-aws-creds/producer-workspace" }
variable "consumer_wd"         { default = "infrastructure-as-code/dynamic-aws-creds/consumer-workspace" }

# Create Producer workspace with new Org, Producer team, and Consumer team
module "producer_workspace" {
  # source = "github.com/hashicorp-modules/terraform-tfe-workspace"
  source = "../../../terraform-tfe-workspace"

  tfe_token                = "${var.tfe_token}"
  tfe_org_name             = "${var.tfe_org_name}"
  tfe_org_email            = "${var.tfe_org_email}"
  tfe_producer_name        = "${var.producer_name}"
  tfe_producer_team_access = "admin"
  tfe_consumer_name        = "${var.consumer_name}-read"
  tfe_consumer_team_access = "read"
  vcs_repo_identifier      = "${var.vcs_repo_identifier}"
  vcs_repo_branch          = "${var.vcs_repo_branch}"
  working_directory        = "${var.producer_wd}"
}

# Create Consumer workspace with existing Org, Producer team, and Consumer teams
module "consumer_workspace" {
  # source = "github.com/hashicorp-modules/terraform-tfe-workspace"
  source = "../../../terraform-tfe-workspace"

  tfe_token                = "${var.tfe_token}"
  tfe_org_name             = "${var.tfe_org_name}"
  tfe_org_email            = "${var.tfe_org_email}"
  tfe_org_id               = "${module.producer_workspace.org_id}"
  tfe_producer_team_id     = "${module.producer_workspace.producer_team_id}"
  tfe_producer_team_access = "admin"
  tfe_consumer_name        = "${var.consumer_name}-write"
  tfe_consumer_team_id     = "${module.producer_workspace.consumer_team_id}"
  tfe_consumer_team_access = "write"
  vcs_repo_identifier      = "${var.vcs_repo_identifier}"
  vcs_repo_branch          = "${var.vcs_repo_branch}"
  working_directory        = "${var.consumer_wd}"
}

output "zPRODUCERREADME" {
  value = "${module.producer_workspace.zREADME}"
}

output "zCONSUMERREADME" {
  value = "${module.consumer_workspace.zREADME}"
}
