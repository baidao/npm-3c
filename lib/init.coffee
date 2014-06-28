'use strict'

fs = require 'fs'
path = require 'path'

init = ->
  root = process.cwd()
  schemaDirPath = path.resolve root, 'schema'
  docDirPath = path.resolve root, 'doc'
  formatDirPath = path.resolve root, 'format'
  configPath = path.resolve schemaDirPath, 'config.json'
  schemaDemoPath = path.resolve schemaDirPath, 'demo.js'
  formatDemoPath = path.resolve formatDirPath, 'format.js'

  !fs.existsSync(schemaDirPath) and fs.mkdirSync(schemaDirPath)
  !fs.existsSync(docDirPath) and fs.mkdirSync(docDirPath)
  !fs.existsSync(formatDirPath) and fs.mkdirSync(formatDirPath)

  unless fs.existsSync(configPath)
    configTplPath = path.resolve __dirname, './templates/config.tpl'
    tmpl = fs.readFileSync configTplPath, 'utf-8'
    fs.writeFileSync configPath, tmpl, 'utf-8'

  unless fs.existsSync(schemaDemoPath)
    demoTplPath = path.resolve __dirname, './templates/demo.tpl'
    tmpl = fs.readFileSync demoTplPath, 'utf-8'
    fs.writeFileSync schemaDemoPath, tmpl, 'utf-8'

  unless fs.existsSync(formatDemoPath)
    formatTplPath = path.resolve __dirname, './templates/format.tpl'
    tmpl = fs.readFileSync formatTplPath, 'utf-8'
    fs.writeFileSync formatDemoPath, tmpl, 'utf-8'

  console.info '############# \n inited.. \n#############'

module.exports = init: init
