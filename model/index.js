
var pgNative = require('pg-native');
var conString = "postgres://alert:%40l3rt@localhost:5432/alert_server";

var client = new pgNative()
client.connectSync(conString);


module.exports = {

  getClients: function(){
    var rows = client.querySync("Select * from client");
    return rows[0].client_name;
  },
  getClientIp: function(name){
    var rows = client.querySync("Select client_ip from client where client_name = $1", [name]);
    return rows[0].client_ip;
  },
  getClientAlertsCount: function(name){
    var rows = client.querySync('\
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
    return rows[0].numalerts;
  },
  getClientAlerts: function(name){
    var rows = client.querySync("Select * \
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
    return rows;
  }

};
