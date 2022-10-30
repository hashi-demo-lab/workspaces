

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
    tag_names = ["tag1", "tag2"]
    vars      = {}
  },
  {
    name      = "app-demoapp-azure-prod"
    dirMap    = { app-demoapp-azure-prod = "" }
    vcs_repo  = "tfc-basic-azure-vm"
    tag_names = ["tag3", "tag4"]
    vars      = {}
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