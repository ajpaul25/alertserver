'use strict';

module.exports = (request, reply) => {
  var data = {};
  var db = require('../model/');
  data.numalerts = db.getClientAlertsCount(request.params.clientname);
  if( request.query.detail )
  {
    data.alerts = db.getClientAlerts(request.params.clientname);
    data.alerts_string = JSON.stringify(data.alerts);
  }
  if( request.query.json )
    return data;
  else
    return reply.view("alerts", data);
};
