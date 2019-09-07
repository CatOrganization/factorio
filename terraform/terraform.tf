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

resource "aws_s3_bucket" "bucketthing" {
  bucket_prefix = "tf-state"
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = "terraform-lock"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}
