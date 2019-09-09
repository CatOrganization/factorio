variable "name" {
  description = "Name of the factorio action, binary, and source code"
}

variable "lambda_role_arn" {
  description = "The IAM arn of the role to apply to this lambda"
}

variable "source_bucket" {
  description = "S3 bucket where source code lives"
}

variable "built_prefix" {
  description = "Path prefix where the built artifcats are (source and zip"
  default = "../built"
}
