'use strict'

fs = require 'fs'
path = require 'path'
restify = require 'restify'

create = (config) ->
  files = config.files or []
  checkDirPath = path.resolve __dirname, './templates/check.tpl'
  port = 4321
  server = restify.createServer
    name: 'check server'
    version: '0.0.1'
  server.get '/', (req, res, next) ->
    html = fs.readFileSync checkDirPath, 'utf-8'
    res.write html
    res.end()
    next()
  server.get '/schemas', (req, res, next) ->
    result = {}
    files.forEach (file) ->
      filePath = path.resolve process.cwd(), "./schema/#{file}"
      result[file] = require filePath
    res.send result
  server.listen port, ->
    console.info "############# \n check server #{server.name} listening at #{port} ... \n#############"

module.exports =
  create: create
