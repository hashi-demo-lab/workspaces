

vcs_org        = "hashicorp-demo-lab"
vcs_repo       = "workspaces"
organization   = "demo-lab-hashicorp"
oauth_token_id = "ot-piMSpsLL6AabsWSi"
tag_names      = ["app"]


triggers = {}


# workspace array
workspaces = [
  {
    name      = "app-demo-dev"
    dirMap    = { app-demo-dev = "test" }
    vcs_repo  = "workspaces"
    tag_names = ["tag1", "tag2"]
    vars      = {}
  },
  {
    name      = "app-demo-prod"
    dirMap    = { app-demo-prod = "" }
    vcs_repo  = "workspaces"
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