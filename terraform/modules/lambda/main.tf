locals {
  function_name = "factorio-${var.name}"
}


resource "aws_lambda_function" "test-lambda" {
  function_name = local.function_name
  role          = var.lambda_role_arn

  runtime   = "go1.x"
  handler   = var.name
  s3_key    = aws_s3_bucket_object.source_object.key
  s3_bucket = var.source_bucket
}

resource "aws_s3_bucket_object" "source_object" {
  bucket = var.source_bucket
  key    = "${var.name}-${data.archive_file.source_code_zip.output_md5}.zip"
  source = data.archive_file.source_code_zip.output_path
}


data "archive_file" "source_code_zip" {
  type        = "zip"
  output_path = "${var.built_prefix}/${var.name}.zip"
  source_file = "${var.built_prefix}/${var.name}"
}

resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name = "/aws/lambda/${aws_lambda_function.test-lambda.function_name}"
}
