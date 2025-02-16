# Default config
variable "tag-name" {
  default = "my-team"
}

variable "region" {
  type    = string
  default = "eu-west-1"
}

# Default ECS config
variable "app_name" {
  type    = string
  default = "myapp"
}

variable "ecr_image" {
  type    = string
  default = "605134467471.dkr.ecr.eu-west-1.amazonaws.com/my-app-ecr:wagtail"
}

variable "ecs_role" {
  type    = string
  default = "arn:aws:iam::605134467471:role/Role_Terraform_Provision_Resources"
}

#Config for service
variable "subnet_ids" {
  type    = list(string)
  default = ["subnet-0a67ccfdea128f704", "subnet-0acc4dd9d13159dd6"]
}
