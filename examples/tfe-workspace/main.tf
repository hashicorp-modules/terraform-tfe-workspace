variable "tfe_token"     {}
variable "tfe_org_name"  {}
variable "tfe_org_email" {}

module "workspace" {
  # source = "github.com/hashicorp-modules/terraform-tfe-workspace"
  source = "../../../terraform-tfe-workspace"

  tfe_token     = "${var.tfe_token}"
  tfe_org_name  = "${var.tfe_org_name}"
  tfe_org_email = "${var.tfe_org_email}"
}

output "zREADME" {
  value = "${module.workspace.zREADME}"
}
