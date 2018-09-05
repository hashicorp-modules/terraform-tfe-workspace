variable "tfe_token"           {}
variable "tfe_org_name"        {}
variable "tfe_org_email"       {}
variable "vcs_repo_identifier" { default = "hashicorp-modules/terraform-tfe-workspace" }

module "workspace" {
  source = "../../../terraform-tfe-workspace"
  # source  = "hashicorp-modules/workspace/tfe"

  tfe_token           = "${var.tfe_token}"
  tfe_org_name        = "${var.tfe_org_name}"
  tfe_org_email       = "${var.tfe_org_email}"
  vcs_repo_identifier = "${var.vcs_repo_identifier}"
}

output "zREADME" {
  value = "${module.workspace.zREADME}"
}
