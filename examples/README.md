# TFE Quick Start Examples

## Prerequisites

1. Create new user account: https://app.terraform.io/account/new
1. Generate token: https://app.terraform.io/app/settings/tokens
1. [Export environment variables](#export-env-vars-example): You can alternatively enter these when prompted, though you'll have to do it every Terraform command

## [TFE Workspace Example](./tfe-workspace)

1. Fork the [`hashicorp-modules/terraform-tfe-workspace`](https://github.com/hashicorp-modules/terraform-tfe-workspace) repo
1. `$ terraform init`
1. `$ terraform plan`
1. `$ terraform apply`
1. This apply will fail initially with the error `tfe_workspace.producer: Error creating workspace tfe-workspace-producer for organization tfe-workspace-org...` as there's not yet a resource for configuring the VCS provider on the org, configure the VCS provider following [these instructions](https://www.terraform.io/docs/enterprise/vcs/github.html) and `terraform apply` again
    - Run `terraform taint -module=workspace "null_resource.tfe_oauth_token"` to re-create the oAuth token
1. Follow the README instructions output from `terraform apply` in the previous step

## [Dynamic AWS Creds Example](./dynamic-aws-creds)

1. Fork the [`hashicorp/terraform-guides`](https://github.com/hashicorp/terraform-guides) repo
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
