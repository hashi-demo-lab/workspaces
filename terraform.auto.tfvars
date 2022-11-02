

vcs_org        = "hashicorp-demo-lab"
vcs_repo       = "workspaces"
organization   = "demo-lab-hashicorp"
oauth_token_id = "ot-piMSpsLL6AabsWSi"
tag_names      = ["app"]

triggers = {}


# workspace array
workspaces = [
  {
    name      = "app-demoapp-aws-prod"
    dirMap    = { app-demoapp-aws-prod = "" }
    vcs_repo  = "tfc-basic-aws-ec2"
    tag_names = ["app", "azure"]
    vars      = {}
  },
  {
    name      = "app-demoapp-azure-prod"
    dirMap    = { app-demoapp-azure-prod = "" }
    vcs_repo  = "tfc-basic-azure-vm"
    tag_names = ["app","azure"]
    vars      = {}
  },
   {
    name      = "security-policytest-aws-test"
    dirMap    = { security-policytest-aws-test = "" }
    vcs_repo  = "tfc-basic-aws-ec2"
    tag_names = ["security"]
    vars      = {}
  }
]

teams = [
    {
      name                    = "acme_security"
      access                  = "admin"
      visibility              = {}
      managevcs               = false
      manage_policies         = true
      manage_providers        = false
      manage_modules          = false
      manage_run_tasks        = true
      manage_policy_overrides = true
      team_members            = ["acme9sec"]
      workspaces              = ["security-policytest-aws-test"]
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
      team_members            = ["acme9app1"]
      workspaces              = ["app-demoapp-aws-prod", "app-demoapp-azure-prod"]
    }
  ]

#var_sets = {
/*   test = {
    desc   = "Testing"
    global = false
    vars = {
      a = {
        val       = 1
        sensitive = false
        desc      = "woohoo"
        category  = "env"
      }
      b = {
        val       = 2
        sensitive = true
      }
    } 
     workspaces = [
      "workspace1",
      "workspace2",
    ]
  } 
}*/