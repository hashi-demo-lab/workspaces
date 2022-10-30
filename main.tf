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
      name = "platform-workspace-prod"
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

locals {
  workspace_teams = { for team in var.teams : team.name => team }

  team_to_workspace = flatten([for team in local.workspace_teams : [
    for workspace in team.workspaces : {
      team             = team.name
      workspace_access = team.access
      workspace        = workspace
    }
    ]
  ])
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


data "tfe_workspace_ids" "all-workspaces" {
  names        = ["*"]
  organization = var.organization
}



resource "tfe_team_access" "team_access" {

  for_each = { for workspace_access in local.team_to_workspace : "${workspace_access.team}-${workspace_access.workspace}" => workspace_access }

  access       = each.value.workspace_access
  team_id      = tfe_team.team[each.value["team"]].id
  //workspace_id = data.tfe_workspace_ids.all-workspaces.full_names[each.value["workspace"]].id
  workspace_id = (lookup(data.tfe_workspace_ids.all-workspaces.full_names,each.value["workspace"])).id

}

output "workspaces" {
  value = module.workspaces
}