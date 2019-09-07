
resource "aws_lambda_function" "test-lambda" {
  function_name = var.name
  role          = aws_iam_role.lambda_role.arn

  runtime   = "go1.x"
  handler   = var.name
  s3_key    = aws_s3_bucket_object.source_object.key
  s3_bucket = aws_s3_bucket.source_bucket.bucket
}

resource "aws_iam_role" "lambda_role" {
  name_prefix        = "${var.name}_role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}

resource "aws_iam_role_policy" "lambda_role_policy" {
  role   = aws_iam_role.lambda_role.id
  policy = data.aws_iam_policy_document.lambda_role_policy.json
}

data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]

    principals {
      type = "Service"
      identifiers = [
        "lambda.amazonaws.com"
      ]
    }
  }
}

data "aws_iam_policy_document" "lambda_role_policy" {
  statement {
    effect = "Allow"

    actions   = ["*"]
    resources = ["*"]
  }
}

resource "aws_s3_bucket" "source_bucket" {
  bucket_prefix = var.sourceBucket
}

resource "aws_s3_bucket_object" "source_object" {
  bucket = aws_s3_bucket.source_bucket.bucket
  key    = "${var.name}-${data.archive_file.source_code_zip.output_md5}.zip"
  source = data.archive_file.source_code_zip.output_path
}


data "archive_file" "source_code_zip" {
  type        = "zip"
  output_path = "${var.builtPrefix}/${var.name}.zip"
  source_file = "${var.builtPrefix}/${var.name}"
}

resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name = "/aws/lambda/${aws_lambda_function.test-lambda.function_name}"
}
