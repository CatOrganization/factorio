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
    sid    = "EC2"
    effect = "Allow"

    actions = [
      "ec2:StartInstances",
      "ec2:StopInstances",
    ]
    resources = [
        "arn:aws:ec2:${var.region}:${var.account}:instances/*",
    ]
  }

  statement {
    sid    = "EC2Describe"
    effect = "Allow"

    actions = [
      "ec2:Describe*",
      "ec2:*Instances"
    ]
    resources = [
      "*"
    ]
  }

  statement {
    sid    = "CloudWatch"
    effect = "Allow"

    actions = [
      "cloudwatch:Put*",
      "logs:CreateLogGroup",
    ]
    resources = [
      "*"
    ]
  }

  statement {
    sid    = "LogStream"
    effect = "Allow"

    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
    resources = [
      "arn:aws:logs:${var.region}:${var.account}:log-group:/aws/lambda/factorio-*"
    ]
  }
}

module "hello_lambda" {
  source = "./modules/lambda"

  name            = "hello"
  source_bucket   = aws_s3_bucket.source_bucket.bucket
  lambda_role_arn = aws_iam_role.lambda_role.arn
}

module "start_factorio" {
  source = "./modules/lambda"

  name            = "start"
  source_bucket   = aws_s3_bucket.source_bucket.bucket
  lambda_role_arn = aws_iam_role.lambda_role.arn
}
