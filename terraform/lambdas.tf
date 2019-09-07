//
//resource "aws_lambda_function" "test-lambda" {
//  function_name = "TestLambda"
//  role          = aws_iam_role.lambda_role.arn
//
//  runtime   = "go1.x"
//  handler   = "hello"
//  s3_key    = aws_s3_bucket_object.source_object.key
//  s3_bucket = aws_s3_bucket.source_bucket.bucket
//}
//
//resource "aws_iam_role" "lambda_role" {
//  name_prefix        = "test_lambda_role"
//  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
//}
//
//resource "aws_iam_role_policy" "lambda_role_policy" {
//  role   = aws_iam_role.lambda_role.id
//  policy = data.aws_iam_policy_document.lambda_role_policy.json
//}
//
//data "aws_iam_policy_document" "lambda_assume_role_policy" {
//  statement {
//    sid    = "ItsATestWHoCares"
//    effect = "Allow"
//    actions = [
//      "sts:AssumeRole"
//    ]
//
//    principals {
//      type = "Service"
//      identifiers = [
//        "lambda.amazonaws.com"
//      ]
//    }
//  }
//}
//
//data "aws_iam_policy_document" "lambda_role_policy" {
//  statement {
//    sid    = "ItsATestWHoCaresAgain"
//    effect = "Allow"
//
//    actions   = ["*"]
//    resources = ["*"]
//  }
//}
//
//
//resource "aws_s3_bucket" "source_bucket" {
//  bucket_prefix = "factorio-lambda"
//}
//
//resource "aws_s3_bucket_object" "source_object" {
//  bucket = aws_s3_bucket.source_bucket.bucket
//  key    = "test-${data.archive_file.source_code_zip.output_md5}.zip"
//  source = data.archive_file.source_code_zip.output_path
//}
//
//data "archive_file" "source_code_zip" {
//  type        = "zip"
//  output_path = "../hello.zip"
//  source_file = "../hello"
//}
//
//resource "aws_cloudwatch_log_group" "lambda_log_group" {
//  name = "/aws/lambda/${aws_lambda_function.test-lambda.function_name}"
//}
