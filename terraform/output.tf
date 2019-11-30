output api_url {
  value = module.apigateway.api_url
}

output slack_events_url {
  value = "${module.apigateway.api_url}/slack/events"
}

output slack_install_url {
  value =  local.single_workspace ? "" : "${module.apigateway.api_url}/install"
}

output slack_oauth_redirect_url {
  value = local.single_workspace ? "" : "${module.apigateway.api_url}/oauth"
}
