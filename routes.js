'use strict';
const Controller = require('./controller/');

module.exports = [
{
  method: 'GET',
  path: '/',
  handler: Controller.home
},
{
  method: 'GET',
  path: '/alerts/{clientname}/{params*}',
  handler: Controller.alerts
},
{
  method: 'GET',
  path: '/assets/{dir}/{name}',
  handler: (request, reply) => {
    return reply.file('./assets/' + encodeURIComponent(request.params.dir) + '/' + encodeURIComponent(request.params.name));
  }
}
];
