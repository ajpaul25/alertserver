'use strict';

const Hapi = require('hapi');
const Inert = require('inert');
const HapiPino = require('hapi-pino');
const Handlebars = require('handlebars');
const Vision = require('vision');

const Settings = require('./settings.js');
const Routes = require('./routes.js');

const server = Hapi.server({
    port: Settings.port,
    host: Settings.host
});

server.route(Routes);


const init = async () => {

    await server.register({
      plugin: HapiPino,
      options: {
        prettyPrint: false,
	      logEvents: ['response']
      }
    });
    await server.register(Inert);

    await server.register(Vision);
    server.views({
      engines: {
        html: Handlebars
      },
      relativeTo: __dirname,
      path: 'view'
    });

    await server.start();
    console.log(`Server running at: ${server.info.uri}`);
};

process.on('unhandledRejection', (err) => {

    console.log(err);
    process.exit(1);
});

init();
