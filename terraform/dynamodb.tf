resource "aws_dynamodb_table" "teams" {
  count = local.single_workspace ? 0 : 1

  name           = var.dynamodb_table_name
  hash_key       = "team_id"
  read_capacity  = var.dynamodb_read_capabity
  write_capacity = var.dynamodb_write_capabity
  billing_mode   = var.dynamodb_billing_mode

  attribute {
    name = "team_id"
    type = "S"
  }

  server_side_encryption {
    enabled = true
  }

  tags = var.tags
}

data aws_iam_policy_document dynamodb {
  count = local.single_workspace ? 0 : 1

  statement {
    actions = [
      "dynamodb:DescribeTable",
      "dynamodb:Query",
      "dynamodb:Scan",
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:UpdateItem",
      "dynamodb:DeleteItem"
    ]

    resources = [aws_dynamodb_table.teams[0].arn]
  }
}

resource aws_iam_policy dynamodb {
  count = local.single_workspace ? 0 : 1

  name   = "AccessTeamsDynamoDBTable-${var.dynamodb_table_name}"
  policy = data.aws_iam_policy_document.dynamodb[0].json
}

resource aws_iam_role_policy_attachment dynamodb {
  count = local.single_workspace ? 0 : 1

  role       = module.apigateway.lambda_role_name
  policy_arn = aws_iam_policy.dynamodb[0].arn
}
