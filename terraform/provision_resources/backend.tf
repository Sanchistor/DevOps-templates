terraform {
  backend "s3" {
    bucket = "my-team-tf-state"
    key    = "deployment_state/terraform_state.tfstate"
    region = "eu-west-1"
  }
}

