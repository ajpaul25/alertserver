'use strict';

module.exports = (request, reply) => {
  var data = [];
  return reply.view("index", data);
};
