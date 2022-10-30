variable "aws_secret_access_key" {
  description = "AWS secret key - set in env vars"
  type        = string
  sensitive   = true
}

variable "aws_access_key_id" {
  description = "AWS key id - set in env vars"
  type        = string
  sensitive   = true
}

variable "oauth_token_id" {
  description = "ID of the oAuth token for the VCS connection"
  type        = string
}

variable "organization" {
  description = "TF Organization to create workspaces under"
  type        = string
}

variable "tf_version" {
  description = "Version of Terraform to use in workspace"
  type        = string
  default     = null
}

variable "vcs_org" {
  description = "The Github organization that repositories live under"
  type        = string
}

variable "vcs_repo" {
  description = "The Github repository name that is backing this workspace"
  type        = string
}

/* variable "workspaces" {
  description = "Workspaces map where we define workspace and its path"
  type        = map(any)
  default     = {}
} */

variable "slacks" {
  description = "Map definning Slack notification options"
  type        = map(any)
  default     = {}
}

variable "triggers" {
  description = "Map for TFE trigger relations workspace->workspace2"
  type        = map(any)
  default     = {}
}

variable "execution_mode" {
  description = "Terraform worskapce execution more: remote, local or agent"
  type        = string
  default     = "remote"
}

variable "tag_names" {
  description = "List of workspace tag names"
  type        = list(any)
  default     = []
}

variable "vars" {
  description = "Map defining workspace variables"
  type        = map(any)
  default     = {}
}

variable "sec_vars" {
  description = "Map defining workspace sensitive variables"
  type        = map(any)
  default     = {}
}


variable "var_sets" {
  description = "Map defining variable sets"
  type        = any
  # TODO: refactor using optional values when TF v1.3 is released
  #map(object({
  #desc       = optional(string)
  #global     = optional(bool, false)
  #vars       = map(any)
  #workspaces = optional(list(string))
  #}))
  default = {}
}

variable "TFC_WORKSPACE_NAME" {
  description = "TFC workspace name from the ENV"
  type        = string
  default     = null
}

variable "workspaces" {
  type = list(object({
    name      = string
    dirMap    = map(any)
    vcs_repo  = string
    tag_names = optional(list(string))
    vars      = map(any)
  }))
  default = [
    {
      name      = "app-demoapp-aws-prod"
      dirMap    = { app-demo-dev = "" }
      vcs_repo  = "tfc-basic-aws-ec2"
      tag_names = ["tag1", "tag2"]
      vars      = {}
    },
    {
      name      = "app-demoapp-azure-prod"
      dirMap    = { app-demo-prod = "" }
      vcs_repo  = "tfc-basic-aws-ec2"
      tag_names = ["tag3", "tag4"]
      vars      = {}
    }
  ]
}


variable "teams" {
  type = list(object({
    name                    = string
    access                  = string
    visibility              = map(any)
    managevcs               = bool
    manage_policies         = bool
    manage_providers        = bool
    manage_modules          = bool
    manage_run_tasks        = bool
    manage_policy_overrides = bool
    team_members            = list(string)
    workspaces              = list(string)

  }))
  default = [
    {
      name                    = "acme_security"
      access                  = "admin"
      visibility              = {}
      managevcs               = false
      manage_policies         = false
      manage_providers        = false
      manage_modules          = false
      manage_run_tasks        = false
      manage_policy_overrides = false
      team_members            = ["acme9sec"]
      workspaces              = []
    },
    {
      name                    = "acme_appteam1"
      access                  = "admin"
      visibility              = {}
      managevcs               = false
      manage_policies         = false
      manage_providers        = false
      manage_modules          = false
      manage_run_tasks        = false
      manage_policy_overrides = false
      team_members            = ["acme9sec"]
      workspaces              = []
    }
  ]
}
