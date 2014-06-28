'use strict'

markdown = require './lib/markdown'
server = require './lib/server'
generator = require './lib/generator'

# 默认配置
DEFAULTS =
  configFile: './schema/config.json'

if module is require.main
  config = require DEFAULTS.configFile
  # markdown
  markdown.create config
  # mock server
  server.create config
  # extend generator format
  generator.extend config