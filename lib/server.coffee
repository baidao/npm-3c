restify = require 'restify'
zSchema = require	"z-schema"
path = require "path"

create = (config) ->
	files = config.files or []
	port = config.port or 4321
	# 启动restify server
	server = restify.createServer
  	name: 'mock server'
  	version: '0.0.1'
  server.use restify.acceptParser(server.acceptable)
	server.use restify.queryParser()
	server.use restify.bodyParser()
	files.forEach (file) ->
		filePath = path.resolve process.cwd(), "./schema/#{file}"
		schemas = require filePath
		schemas.forEach (schema) ->
			type = (schema.meta?.method or 'get').toLowerCase()
			uri = schema.meta?.uri or '/test'
			server[type] uri, (req, res, next) ->
				json = req.body
				json = req.params if type is 'get' #如果是get请求 使用params
				#schema验证
				zSchema.validate(json, schema.params).then((report) ->
					# 通过验证
					res.send "ok"
				).catch((err) ->
					# 没有通过验证
					console.error err
					res.send "nop"
				)
	server.listen port, ->
		console.info "############# \n #{server.name} listening at #{port} ... \n#############"

module.exports =
	create: create