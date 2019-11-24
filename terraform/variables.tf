locals {
  slack_credentials    = jsondecode(data.aws_secretsmanager_secret_version.slack.secret_string)
  slack_signing_secret = local.slack_credentials["SLACK_SIGNING_SECRET"]
  slack_client_id      = local.slack_credentials["SLACK_CLIENT_ID"]
  slack_client_secret  = local.slack_credentials["SLACK_CLIENT_SECRET"]
}

variable api_name {
  type = string
}

variable lambda_function_name {
  type = string
}

variable secret_name {
  type        = string
  description = "The Secrets Manager secret containing the Slack credentials"
}

variable circleci_user {
  type    = string
  default = "CircleCI"
}

variable command {
  type        = string
  default     = "secret-message"
  description = "The command used to send a secret message"
}

variable dynamodb_table_name {
  type        = string
  default     = "teams"
  description = "The name of the DynamoDB table to store Slack Team install details"
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
  default = "eu-west-2"
}
