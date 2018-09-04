# TFE Quick Start Examples

## Prerequisites

1. Create new user account: https://app.terraform.io/account/new
1. Generate token: https://app.terraform.io/app/settings/tokens

## [TFE Workspace Example](./tfe-workspace)

1. Fork the [`hashicorp-modules/terraform-tfe-workspace`](https://github.com/hashicorp-modules/terraform-tfe-workspace) repo
1. [Export environment variables](#export-env-vars). You can alternatively enter these when prompted, though you'll have to do it every Terraform command.
  - `TFE_TOKEN` will be copied from the "Generate token" step above
1. `$ terraform init`
1. `$ terraform plan`
1. `$ terraform apply`
1. Follow the README instructions output from `terraform apply` in the previous step

### Export Env Vars Example

```
export TF_VAR_tfe_org_name=YOUR_ORG_NAME # Desired org name
export TF_VAR_tfe_org_email=YOUR_EMAIL # Desired org email
export TF_VAR_tfe_token=YOUR_TFE_TOKEN # TFE token generated above
export TF_VAR_vcs_repo_identifier=YOUR_GITHUB_USERNAME/terraform-tfe-workspace
```

## [Dynamic AWS Creds Example](./tfe-workspace)

1. Fork the [`hashicorp/terraform-guides`](https://github.com/hashicorp/terraform-guides) repo
1. [Export environment variables](#export-env-vars). You can alternatively enter these when prompted, though you'll have to do it every Terraform command.
  - `TFE_TOKEN` will be copied from the "Generate token" step above
1. `$ terraform init`
1. `$ terraform plan`
1. `$ terraform apply`
1. Follow the README instructions output from `terraform apply` in the previous step

### Export Env Vars Example

```
export TF_VAR_tfe_org_name=tfe_trial_example # Desired org name
export TF_VAR_tfe_org_email=tfe_trial@example.com # Desired org email
export TF_VAR_tfe_token=${TFE_TOKEN} # This command assumes the TFE token generated above is set in your environment as TFE_TOKEN
export TF_VAR_vcs_repo_identifier=YOUR_GITHUB_USERNAME/terraform-guides
```
