terraform {
  required_version = ">= 0.13.6, < 2.0"
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = ">= 0.35.0"
    }
  }

  cloud {
    organization = "demo-lab-hashicorp"

    workspaces {
      name = "tfworkspace-master"
    }
  }
}


module "workspaces" {
  for_each = { for workspace in var.workspaces : workspace.name => workspace }

  source  = "scalefactory/workspaces/tfe"
  version = "1.2.0"

  organization       = var.organization
  oauth_token_id     = var.oauth_token_id
  vcs_org            = var.vcs_org
  vcs_repo           = each.value.vcs_repo
  workspaces         = each.value.dirMap
  slacks             = var.slacks
  triggers           = var.triggers
  TFC_WORKSPACE_NAME = var.TFC_WORKSPACE_NAME

  var_sets = var.var_sets

  sec_vars = {}
}

resource "tfe_team" "team" {
  for_each = { for team in var.teams : team.name => team }

  name         = each.value.name
  organization = var.organization
  organization_access {
    manage_vcs_settings     = each.value.managevcs
    manage_policies         = each.value.manage_policies
    manage_policy_overrides = each.value.manage_policy_overrides
    manage_run_tasks        = each.value.manage_run_tasks
    manage_providers        = each.value.manage_providers
    manage_modules          = each.value.manage_modules
  }
}

resource "tfe_team_members" "team_members" {
  for_each = { for team in var.teams : team.name => team }

  team_id   = tfe_team.team[each.key].id
  usernames = each.value.team_members
}

# Need to loop through each team acccess #not teams
/* resource "tfe_team_access" "team_access" {
  for_each = { for team in var.teams : team.name => team }

  access       = "admin"
  team_id      = tfe_team.team[each.key].id
  workspace_id = ""

} */


output "workspaces" {
  value = module.workspaces
}