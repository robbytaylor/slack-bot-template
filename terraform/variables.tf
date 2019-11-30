locals {
  slack_credentials    = jsondecode(data.aws_secretsmanager_secret_version.slack.secret_string)
  slack_signing_secret = local.slack_credentials["SLACK_SIGNING_SECRET"]
  slack_bot_token      = lookup(local.slack_credentials, "SLACK_BOT_TOKEN", "")
  slack_client_id      = lookup(local.slack_credentials, "SLACK_CLIENT_ID", "")
  slack_client_secret  = lookup(local.slack_credentials, "SLACK_CLIENT_SECRET", "")

  single_workspace = var.single_workspace
}

variable api_name {
  type = string
}

variable lambda_function_name {
  type = string
}

variable circleci_user {
  type    = string
  default = "CircleCI"
}

variable dynamodb_billing_mode {
  type    = string
  default = "PAY_PER_REQUEST"
}

variable dynamodb_read_capabity {
  type    = number
  default = 0
}

variable dynamodb_table_name {
  type        = string
  default     = "teams"
  description = "The name of the DynamoDB table to store Slack Team install details"
}

variable dynamodb_write_capabity {
  type    = number
  default = 0
}

variable lambda_handler {
  type    = string
  default = "handler.app"
}

variable lambda_runtime {
  type    = string
  default = "nodejs10.x"
}

variable route53_hosted_zone {
  type    = string
  default = ""
}

variable domain_name {
  type    = string
  default = ""
}

variable region {
  type    = string
  default = "eu-west-1"
}

variable single_workspace {
  type        = bool
  default     = true
  description = "Whether the app should be for a single workspace or available for distribution"
}

variable secret_name {
  type        = string
  default     = "slack-secrets"
  description = "The Secrets Manager secret containing the Slack credentials"
}

variable slack_scopes {
  type        = string
  default     = "bot,commands,chat:write:bot"
  description = "The required Slack OAuth scopes for the app. Used for generate an install link"
}

variable tags {
  type    = map
  default = {}
}
