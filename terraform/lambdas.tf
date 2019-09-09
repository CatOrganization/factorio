resource "aws_s3_bucket" "source_bucket" {
  bucket_prefix = "factorio-lambda"
}

resource "aws_iam_role" "lambda_role" {
  name_prefix        = "tf_lambda_role"
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

module "hello_lambda" {
  source = "./modules/lambda"

  name = "hello"
  lambda_role_arn = aws_iam_role.lambda_role.arn
}

module "factorio_lambda" {
  source = "./modules/lambda"

  name = "factorio"
  lambda_role_arn = aws_iam_role.lambda_role.arn
}
