'use strict';

const { App, ExpressReceiver } = require('@slack/bolt');

const expressReceiver = new ExpressReceiver({
  signingSecret: process.env.SLACK_SIGNING_SECRET
});

const makeAppWithToken = (token, expressReceiver) => {
  return new App({
    token: token,
    receiver: expressReceiver
  });
}

const makeAppWithOauth = expressReceiver => {
  const oauth = require('./lib/oauth');

  const app = new App({
    authorize: oauth.auth,
    receiver: expressReceiver
  });

  oauth.install(expressReceiver.app, app.client);

  return app;
}

const app = (process.env.USE_OAUTH || false) ?
  makeAppWithToken(process.env.SLACK_BOT_TOKEN, expressReceiver)
  : makeAppWithOauth(expressReceiver);

require('./lib/bot')(app);

module.exports.app = require('serverless-http')(expressReceiver.app);
