output "zREADME" {
  value = <<README
After your first apply, TFE will be all setup for you. The Organization, Producer,
and Consumer team tokens are saved as Terraform variables in the Producer
workspace for retrieval.

As a next step, re-initialize Terraform with your newly created workspace
backend so you can begin using it for remote state. A file named `tfe.tf` has
been placed locally which contains the "remote" backend Terraform provider block.
This new provider block will allow you to run the below init command to initialize
the enhanced remote backend for TFE.

Remove the `tfe.tf` file if you want to switch back to local state.

Note that normally you would _not_ pass the `tfe_token` in via the CLI, but
for the sake of simplicity in this example, we are doing that below.

See below best practices for configuring the backend.

https://www.terraform.io/docs/backends/config.html
https://www.terraform.io/docs/backends/types/remote.html#configuration-variables

```
  $ terraform init \
        -backend=true \
        -reconfigure=true \
        -backend-config="organization=${var.tfe_org_id != "" ? var.tfe_org_id : element(tfe_organization.org.*.id, 0)}" \
        -backend-config="token=${var.tfe_producer_team_id != "" ? "<PRODUCER_TEAM_TOKEN>" : element(tfe_team_token.producer.*.token, 0)}" \
        -backend-config="workspaces=[{name=\"${element(tfe_workspace.producer.*.name, 0)}\"}]"
```

You will see the below prompt, enter `yes`.

```
Initializing the backend...
Do you want to copy existing state to the new backend?
  Pre-existing state was found while migrating the previous "local" backend to the
  newly configured "remote" backend. No existing state was found in the newly
  configured "remote" backend. Do you want to copy this state to the new "remote"
  backend? Enter "yes" to copy and "no" to start with an empty state.

  Enter a value: yes
```

Run a plan

  $ terraform plan

Then run the apply through TFE by going to the plan URL output.

You now have the TFE remote backend configured and are safely managing TFE as code!
README
}

output "org_id" {
  value = "${var.tfe_org_id != "" ? var.tfe_org_id : element(tfe_organization.org.*.id, 0)}"
}

output "producer_team_id" {
  value = "${var.tfe_producer_team_id != "" ? var.tfe_producer_team_id : element(tfe_team.producer.*.id, 0)}"
}

output "consumer_team_id" {
  value = "${var.tfe_consumer_team_id != "" ? var.tfe_consumer_team_id : element(tfe_team.consumer.*.id, 0)}"
}

output "producer_workspace_id" {
  value = "${tfe_workspace.producer.id}"
}

output "tfe_oauth_token" {
  value = "${file("./.oauth-token")}"
}
