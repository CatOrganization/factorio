provider "aws" {
  region = "us-east-2"
  version = ">= 2.20"
}

terraform {
  required_version = ">= 0.12.8"

  backend "s3" {
    bucket = "tf-state20190907045434278100000001"
    key = "factorio"
    region = "us-east-2"
    dynamodb_table = "terraform-lock"
  }
}
