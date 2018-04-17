'use strict';

module.exports = async(request, reply) => {

  var data = {};
  var db = require('../model/');
  await db.init();
  data.numalerts = await db.getClientAlertsCount(request.params.clientname);
  if( request.query.detail )
  {
    data.alerts = await db.getClientAlerts(request.params.clientname);
    data.alerts_string = JSON.stringify(data.alerts);
  }
  if( request.query.json )
    return data;
  else
    return reply.view("alerts", data);
};
