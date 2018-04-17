
var pg = require('pg');
var conString = "postgres://alert:alert@localhost:5432/alert_server";

var client;


module.exports = {
  init: async function(){
    client = new pg.Client(conString);
    await client.connect();
  },
  getClients: async function(){
    var res = client.querySync("Select * from client");
    return res.rows[0].client_name;
  },
  getClientIp: async function(name){
    var res = await client.query("Select client_ip from client where client_name = $1", [name]);
    return res.rows[0].client_ip;
  },
  getClientAlertsCount: async function(name){
    var res = await client.query('\
      Select count(alert_id) numalerts \
      from alert \
      where alert_start <= current_timestamp \
      and alert_end >= current_timestamp \
      and alert_clientgroup_id in \
      (select clientgroup_id \
      from clientgroupmember cgm \
      inner join \
      client c \
      on cgm.client_id = c.client_id \
      where client_name = $1) \
      ', [name]);
    return res.rows[0].numalerts;
  },
  getClientAlerts: async function(name){
    var res = await client.query("Select * \
      from alert \
      where alert_start <= current_timestamp \
      and alert_end >= current_timestamp \
      and alert_clientgroup_id in \
      (select clientgroup_id \
      from clientgroupmember cgm \
      inner join \
      client c \
      on cgm.client_id = c.client_id \
      where client_name = $1)", [name]);
    return res.rows;
  }

};
