'use strict'

fs = require 'fs'
path = require 'path'

init = ->
  root = process.cwd()
  schemaDirPath = path.resolve root, 'schema'
  docDirPath = path.resolve root, 'doc'
  configPath = path.resolve schemaDirPath, 'config.json'
  schemaDemoPath = path.resolve schemaDirPath, 'demo.coffee'

  !fs.existsSync(schemaDirPath) and fs.mkdirSync(schemaDirPath)
  !fs.existsSync(docDirPath) and fs.mkdirSync(docDirPath)

  unless fs.existsSync(configPath)
    configTplPath = path.resolve __dirname, './templates/config.tpl'
    tmpl = fs.readFileSync configTplPath, 'utf-8'
    fs.writeFileSync configPath, tmpl, 'utf-8'

  unless fs.existsSync(schemaDemoPath)
    demoTplPath = path.resolve __dirname, './templates/demo.tpl'
    tmpl = fs.readFileSync demoTplPath, 'utf-8'
    fs.writeFileSync schemaDemoPath, tmpl, 'utf-8'

  console.info '############# \n inited.. \n#############'

module.exports = init: init
