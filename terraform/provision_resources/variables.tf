#Bucket config
variable "bucket_name" {
  type    = string
  default = "my-team-tf-state"
}

# Default config
variable "tag-name" {
  default = "my-team"
}

variable "region" {
  type    = string
  default = "eu-west-1"
}

#ECR image name
variable "app_name" {
  type    = string
  default = "my-app-ecr"
}

#RDS config
variable "db-username" {
  type    = string
  default = "username" #move to ssm
}

variable "db-password" {
  type    = string
  default = "123456789" #move to ssm
}

variable "database_name" {
  type    = string
  default = "myappdb"
}
