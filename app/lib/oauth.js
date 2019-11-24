'use strict';

const driver = process.env.STORAGE_DRIVER || 'dynamodb';
const store = require(`./storage/${driver}`);

const installUrl = `https://slack.com/oauth/authorize?client_id=${process.env.SLACK_CLIENT_ID}&scope=${process.env.SLACK_SCOPES}`;

module.exports.install = (app, slack) => {
  app.route('/oauth')
    .get((request, response) => {
      const payload = request.query;

      if (!payload.code) {
        return response.redirect(302, installUrl);
      }

      return slack.oauth
        .access({
          client_id: process.env.SLACK_CLIENT_ID,
          client_secret: process.env.SLACK_CLIENT_SECRET,
          code: payload.code,
          state: payload.state
        })
        .then(data => {
          const save = store.save({
            team_id: data.team_id,
            botToken: data.bot.bot_access_token,
            botId: data.user_id,
            botUserId: data.bot.bot_user_id,
            userToken: data.access_token
          });

          const test = slack.auth.test({ token: data.access_token });

          Promise.all([save, test]).then(results => {
            response.redirect(302, results[1].url);
          });
        })
        .catch(error => {
          response.status(500).send(error.data.error);
        })
    });

  app.route('/install')
    .get((request, response) => {
      response.redirect(302, installUrl);
    })
}

module.exports.auth = ({ teamId }) => {
  return store.get(teamId);
}
