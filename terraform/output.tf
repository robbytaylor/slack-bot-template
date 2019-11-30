output api_url {
  value = module.apigateway.api_url
}

output slack_events_url {
  value = "${module.apigateway.api_url}/slack/events"
}

output slack_install_url {
  value = "${module.apigateway.api_url}/install"
}
