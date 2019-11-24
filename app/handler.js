'use strict';

const { App, ExpressReceiver } = require('@slack/bolt');
const oauth = require('./lib/oauth');

const expressReceiver = new ExpressReceiver({
  signingSecret: process.env.SLACK_SIGNING_SECRET
});

const app = new App({
  authorize: oauth.auth,
  receiver: expressReceiver
});

require('./lib/bot')(app);
oauth.install(expressReceiver.app, app.client)

module.exports.app = require('serverless-http')(expressReceiver.app);
