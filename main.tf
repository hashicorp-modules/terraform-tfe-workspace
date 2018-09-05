provider "tfe" {
  token = "${var.tfe_token}"
}

resource "tfe_organization" "org" {
  count = "${var.tfe_org_id == "" ? 1 : 0}"

  name  = "${var.tfe_org_name}"
  email = "${var.tfe_org_email}"
}

resource "tfe_organization_token" "token" {
  count = "${var.tfe_org_id == "" ? 1 : 0}"

  organization = "${var.tfe_org_id != "" ? var.tfe_org_id : tfe_organization.org.id}"
}

resource "tfe_team" "producer" {
  count = "${var.tfe_producer_team_id == "" ? 1 : 0}"

  name         = "${var.tfe_producer_name}"
  organization = "${var.tfe_org_id != "" ? var.tfe_org_id : tfe_organization.org.id}"
}

resource "tfe_team_token" "producer" {
  count = "${var.tfe_producer_team_id == "" ? 1 : 0}"

  team_id = "${tfe_team.producer.id}"
}

resource "tfe_team" "consumer" {
  count = "${var.tfe_consumer_team_id == "" ? 1 : 0}"

  name         = "${var.tfe_consumer_name}"
  organization = "${var.tfe_org_id != "" ? var.tfe_org_id : tfe_organization.org.id}"
}

resource "tfe_team_token" "consumer" {
  count = "${var.tfe_consumer_team_id == "" ? 1 : 0}"

  team_id = "${tfe_team.consumer.id}"
}

# Retrieve TFE oAuth token: https://github.com/terraform-providers/terraform-provider-tfe/issues/10
# VCS must be enabled in your TFE organization for this to work: https://www.terraform.io/docs/enterprise/vcs/github.html
data "template_file" "tfe_oauth_token" {
  template = "${file("${path.module}/tfe-oauth-token.sh.tpl")}"

  vars = {
    token        = "${var.tfe_token}"
    organization = "${var.tfe_org_name}"
  }

  # Don't generate the oAuth token until we know the organization exists
  depends_on = ["tfe_team.producer"]
}

resource "null_resource" "tfe_oauth_token" {
  triggers = {
    token        = "${var.tfe_token}"
    organization = "${var.tfe_org_name}"
  }

  provisioner "local-exec" {
    command = "${data.template_file.tfe_oauth_token.rendered}"
  }

  # Don't generate the oAuth token until we know the organization exists
  depends_on = ["tfe_team.producer"]
}

# Create Producer workspace
resource "tfe_workspace" "producer" {
  name         = "${var.tfe_producer_name}"
  organization = "${var.tfe_org_id != "" ? var.tfe_org_id : tfe_organization.org.id}"

  # VCS settings
  vcs_repo {
    identifier     = "${var.vcs_repo_identifier}"
    branch         = "${var.vcs_repo_branch}"
    oauth_token_id = "${file("./.oauth-token")}"
  }

  working_directory = "${var.working_directory}"

  # Don't generate the oAuth token until it exists
  depends_on = ["null_resource.tfe_oauth_token"]
}

# Producer team has admin priviledges on "Producer" workspace
resource "tfe_team_access" "producer_team" {
  access       = "${var.tfe_producer_team_access}"
  team_id      = "${var.tfe_producer_team_id != "" ? var.tfe_producer_team_id : tfe_team.producer.id}"
  workspace_id = "${tfe_workspace.producer.id}"
}

# Consumer can read from "Producer" workspace remote state
resource "tfe_team_access" "consumer_team" {
  access       = "${var.tfe_consumer_team_access}"
  team_id      = "${var.tfe_consumer_team_id != "" ? var.tfe_consumer_team_id : tfe_team.consumer.id}"
  workspace_id = "${tfe_workspace.producer.id}"
}

# Store workspace variables in TFE
resource "tfe_variable" "oauth_token" {
  key          = "oauth_token"
  value        = "${file("./.oauth-token")}"
  category     = "terraform"
  sensitive    = true
  workspace_id = "${tfe_workspace.producer.id}"
}

resource "tfe_variable" "tfe_organization_token" {
  count = "${var.tfe_org_id == "" ? 1 : 0}"

  key          = "tfe_organization_token"
  value        = "${tfe_organization_token.token.token}"
  category     = "terraform"
  sensitive    = true
  workspace_id = "${tfe_workspace.producer.id}"
}

resource "tfe_variable" "tfe_producer_team_token" {
  count = "${var.tfe_producer_team_id == "" ? 1 : 0}"

  key          = "tfe_producer_team_token"
  value        = "${tfe_team_token.producer.token}"
  category     = "terraform"
  sensitive    = true
  workspace_id = "${tfe_workspace.producer.id}"
}

resource "tfe_variable" "tfe_consumer_team_token" {
  count = "${var.tfe_consumer_team_id == "" ? 1 : 0}"

  key          = "tfe_consumer_team_token"
  value        = "${tfe_team_token.consumer.token}"
  category     = "terraform"
  sensitive    = true
  workspace_id = "${tfe_workspace.producer.id}"
}

resource "tfe_variable" "tfe_token" {
  key          = "tfe_token"
  value        = "${var.tfe_token}"
  category     = "terraform"
  sensitive    = true
  workspace_id = "${tfe_workspace.producer.id}"
}

resource "tfe_variable" "tfe_org_name" {
  key          = "tfe_org_name"
  value        = "${var.tfe_org_name}"
  category     = "terraform"
  workspace_id = "${tfe_workspace.producer.id}"
}

resource "tfe_variable" "tfe_org_email" {
  key          = "tfe_org_email"
  value        = "${var.tfe_org_email}"
  category     = "terraform"
  workspace_id = "${tfe_workspace.producer.id}"
}

resource "tfe_variable" "tfe_producer_name" {
  key          = "tfe_producer_name"
  value        = "${var.tfe_producer_name}"
  category     = "terraform"
  workspace_id = "${tfe_workspace.producer.id}"
}

resource "tfe_variable" "tfe_consumer_name" {
  key          = "tfe_consumer_name"
  value        = "${var.tfe_consumer_name}"
  category     = "terraform"
  workspace_id = "${tfe_workspace.producer.id}"
}

resource "tfe_variable" "vcs_repo_identifier" {
  key          = "vcs_repo_identifier"
  value        = "${var.vcs_repo_identifier}"
  category     = "terraform"
  workspace_id = "${tfe_workspace.producer.id}"
}

resource "tfe_variable" "vcs_repo_branch" {
  key          = "vcs_repo_branch"
  value        = "${var.vcs_repo_branch}"
  category     = "terraform"
  workspace_id = "${tfe_workspace.producer.id}"
}

resource "tfe_variable" "working_directory" {
  key          = "working_directory"
  value        = "${var.working_directory}"
  category     = "terraform"
  workspace_id = "${tfe_workspace.producer.id}"
}

resource "tfe_variable" "confirm_destroy" {
  key          = "CONFIRM_DESTROY"
  value        = "1"
  category     = "env"
  workspace_id = "${tfe_workspace.producer.id}"
}
