'use strict'

path = require 'path'
init = require './lib/init'
markdown = require './lib/markdown'
server = require './lib/server'
generator = require './lib/generator'

# 默认配置
DEFAULTS =
  configFile: './schema/config.json'

module.exports =
  exec: (argv) ->
    cwd = process.cwd()
    # console.log argv
    # 初始化
    if argv.i or argv.init
      root = argv.i or argv.init
      init.init()
    # 文档生成
    else if argv.doc or argv.d
      # markdown doc
      configPath = path.resolve process.cwd(), DEFAULTS.configFile
      config = require configPath
      markdown.create config
    # mock服务器
    else if argv.mock or argv.m
      # extend generator format
      configPath = path.resolve process.cwd(), DEFAULTS.configFile
      config = require configPath
      generator.extend config
      # mock server
      server.create config

if module is require.main
  # init
  init.init()
  configPath = path.resolve process.cwd(), DEFAULTS.configFile
  config = require configPath
  # markdown
  markdown.create config
  # mock server
  server.create config
  # extend generator format
  generator.extend config

