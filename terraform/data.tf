data "aws_secretsmanager_secret_version" "slack" {
  secret_id = var.secret_name
}
