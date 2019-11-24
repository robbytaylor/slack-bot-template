'use strict';

const AWS = require("aws-sdk"),
  dynamo = new AWS.DynamoDB.DocumentClient();

/**
 * Dynamo Save
 *
 * @param {Object} data - The data to save
 * @return {Promise} A Promise with the save results
 */
module.exports.save = function (data) {
  return this.query('put', { Item: data });
}

/**
 * Dynamo Get
 *
 * @param {String} id - The record's key
 * @return {Promise} A Promise with the get result
 */
module.exports.get = function (id) {
  return this.query('get', { Key: { team_id: id } }).then(d => {
    return Promise.resolve(d.Item);
  });
}

/**
 * Dynamo Query
 *
 * @param {String} name - The query action to run
 * @param {Object} params - The query parameters
 * @return {Promise} A Promise with the get result
 */
module.exports.query = function (method, params) {
  params.TableName = process.env.TABLE_NAME;

  return new Promise((resolve, reject) => {
    dynamo[method](params, (err, data) => {
      err ? reject(err) : resolve(data);
    });
  });
}
