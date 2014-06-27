var DEFAULTS, config, markdown, server;
markdown = require('./lib/markdown');
server = require('./lib/server');
DEFAULTS = {
  configFile: './schema/config.json'
};
if (module === require.main) {
  config = require(DEFAULTS.configFile);
  markdown.create(config);
  server.create(config);
}