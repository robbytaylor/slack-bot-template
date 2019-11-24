data aws_iam_policy_document circleci {
  statement {
    actions   = ["lambda:UpdateFunctionCode"]
    resources = [module.apigateway.lambda_arn]
  }
}

resource "aws_iam_user" "circleci" {
  name = var.circleci_user
  tags = var.tags
}

resource aws_iam_policy update-lambda {
  name   = "UpdateLambda-${var.lambda_function_name}"
  policy = data.aws_iam_policy_document.circleci.json
}

resource "aws_iam_user_policy_attachment" "circleci" {
  user       = aws_iam_user.circleci.name
  policy_arn = aws_iam_policy.update-lambda.arn
}
