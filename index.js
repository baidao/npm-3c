'use strict';
var DEFAULTS, config, generator, markdown, server;
markdown = require('./lib/markdown');
server = require('./lib/server');
generator = require('./lib/generator');
DEFAULTS = {
  configFile: './schema/config.json'
};
if (module === require.main) {
  config = require(DEFAULTS.configFile);
  markdown.create(config);
  server.create(config);
  generator.extend(config);
}