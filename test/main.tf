terraform {
  required_version = ">= 0.13.6, < 2.0"
  cloud {
    organization = "demo-lab-hashicorp"
  }
}


# website::tag::1:: The simplest possible Terraform module: it just outputs "Hello, World!"
output "hello_world" {
  value = "Hello, World!"
}
