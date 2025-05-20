/*
data "terraform_remote_state" "terraform-devl" {
  backend = "remote"
  config = {
    organization = "xascode"
    workspaces = {
      name = "terraform-devl"
    }
  }
}

data "terraform_remote_state" "terraform-test" {
  backend = "remote"
  config = {
    organization = "xascode"
    workspaces = {
      name = "terraform-test"
    }
  }
}

data "terraform_remote_state" "terraform-prod" {
  backend = "remote"
  config = {
    organization = "xascode"
    workspaces = {
      name = "terraform-prod"
    }
  }
}
*/
