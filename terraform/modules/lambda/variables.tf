variable "name" {
  description = "Name of lambda function, binary, and source code"
}

variable "lambda_role_arn" {
  description = "The IAM arn of the role to apply to this lambda"
}

variable "sourceBucket" {
  description = "S3 bucket where source code lives"
  default = "factorio-lambda"
}

variable "builtPrefix" {
  description = "Path prefix where the built artifcats are (source and zip"
  default = "../built"
}
