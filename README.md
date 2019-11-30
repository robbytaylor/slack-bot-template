# Slack Bot Template

Use this template to create a Slack Bot using [Bolt](https://slack.dev/bolt/concepts).

The template app supports authentication with Slack via a bot token or OAuth.
It can therefore be used to create an app for a single workspace or for distribution.
See [Authorization](https://slack.dev/bolt/concepts#authorization) in the Bolt documentation.

Terraform is included for deploying the bot to AWS with API Gateway and Lambda but it could be deployed using any other method.

Customise the bot by editing the `app/lib/bot.js` file.
