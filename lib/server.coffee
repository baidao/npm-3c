'use strict'

_ = require 'underscore'
path = require 'path'
restify = require 'restify'
generator = require './generator'
JaySchema = require 'jayschema'
jaySchema = new JaySchema

create = (config) ->
	files = config.files or []
	# 端口
	port = config.port or 4321
	# 是否强制认为请求失败
	forceError = !!config.forceError
	# 错误码
	errorCode = config.errorCode or 500
	# 启动restify server
	server = restify.createServer
  	name: 'mock server'
  	version: '0.0.1'
  server.use restify.acceptParser server.acceptable
	server.use restify.queryParser()
	server.use restify.bodyParser()
	server.use restify.CORS()
	server.use restify.jsonp()
	server.use restify.gzipResponse()
	files.forEach (file) ->
		filePath = path.resolve process.cwd(), "./schema/#{file}"
		schemas = require filePath
		schemas.forEach (schema) ->
			type = (schema.meta?.method or 'get').toLowerCase()
			type = 'del' if type is 'delete' #restify del not delete..
			uri = schema.meta?.uri or '/test'
			server[type] uri, (req, res, next) ->
				json = req.body
				json = req.params if type is 'get' #如果是get请求 使用params
				# 强制返回请求失败数据
				if forceError
					res.send errorCode, generator.generate schema.error
					next()
				# schema验证
				jaySchema.validate json, schema.params, (errs) ->
					unless errs
		    		success = generator.generate schema.success
		    		res.send 200, success
		    		next()
		    	else
		    		error = _.extend generator.generate(schema.error), validate_errors: errs
		    		res.send errorCode, error
		    		next()

	server.listen port, ->
		console.info "############# \n #{server.name} listening at #{port} ... \n#############"

module.exports =
	create: create