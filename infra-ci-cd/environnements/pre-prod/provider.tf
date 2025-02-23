provider "aws" {
  region     = var.region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

terraform {
  backend "s3" {
    bucket         = "infra-ci-cd-terraform-states"
    key            = "environments/pre-prod/terraform.tfstate"
    region         = var.region
    dynamodb_table = "terraform-lock"
    encrypt        = true
    access_key = var.aws_access_key
    secret_key = var.aws_secret_key
  }
}
