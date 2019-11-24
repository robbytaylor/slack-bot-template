module "apigateway" {
  source = "github.com/robbytaylor/terraform-apigateway-lambda"

  api_name             = var.api_name
  lambda_function_name = var.lambda_function_name
  domain_name          = var.domain_name
  route53_hosted_zone  = var.route53_hosted_zone
  http_methods         = local.slack_bot_token ? ["POST"] : ["GET", "POST"]

  providers = {
    aws     = "aws"
    aws.acm = "aws.acm"
  }

  environment_variables = {
    "SLACK_BOT_TOKEN" : local.slack_bot_token
    "SLACK_CLIENT_ID" : local.slack_client_id
    "SLACK_CLIENT_SECRET" : local.slack_client_secret
    "SLACK_SCOPES" : var.slack_scopes
    "SLACK_SIGNING_SECRET" : local.slack_signing_secret
    "TABLE_NAME" : var.dynamodb_table_name
  }
}
