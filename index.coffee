markdown = require './lib/markdown'
server = require './lib/server'

DEFAULTS =
  configFile: './schema/config.json'

if module is require.main
  config = require DEFAULTS.configFile
  # markdown
  markdown.create config
  # mock server
  server.create config