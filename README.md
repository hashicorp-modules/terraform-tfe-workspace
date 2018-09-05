# TFE Quick Start

Creates a workspace in TFE connected to VCS and sets up the appropriate producer/consumer users and permissions.

See [examples here](https://github.com/hashicorp-modules/terraform-tfe-workspace/tree/master/examples).

## Environment Variables

- `TF_VAR_tfe_org_name`
- `TF_VAR_tfe_org_email`
- `TF_VAR_tfe_token`

## Input Variables

- `tfe_token`: [Required] Token from the TFE account for the TFE provider API access.
- `tfe_org_name`: [Required] Name of organization to be created in TFE.
- `tfe_org_email`: [Required] Email for organziation to be created in TFE.
- `tfe_org_id`: [Optional] ID of organization in TFE to use, if empty, an organization will be created.
- `tfe_producer_name`: [Optional] Name of the "Producer" workspace and team, defaults to "tfe-workspace-producer".
- `tfe_producer_team_id`: [Optional] ID of "Producer" team in TFE to use, if empty, a team will be created.
- `tfe_producer_team_access`: [Optional] Access level for the "Producer" team, defaults to "admin".
- `tfe_consumer_name`: [Optional] Name of the "Consumer" team, defaults to "tfe-workspace-consumer".
- `tfe_consumer_team_id`: [Optional] ID of "Consumer" team in TFE to use, if empty, a team will be created.
- `tfe_consumer_team_access`: [Optional] Access level for the "Consumer" team, defaults to "read".
- `vcs_repo_identifier`: [Optional] Org and repo name for VCS, defaults to `hashicorp-modules/terraform-tfe-workspace`.
- `vcs_repo_branch`: [Optional] github branch name, defaults to "master".
- `working_directory`: [Optional] Working directory for Terraform to run in, defaults to the root directory.

## Outputs

- `zREADME`: The module README.
- `org_id`: The TFE organization ID.
- `producer_team_id`: The TFE Producer team ID.
- `consumer_team_id`: The TFE Consumer team ID.
- `producer_workspace_id`: The TFE Producer workspace ID.


## Authors

HashiCorp Solutions Engineering Team.

## License

Mozilla Public License Version 2.0. See LICENSE for full details.
