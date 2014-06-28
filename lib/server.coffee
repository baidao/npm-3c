'use strict'

path = require 'path'
restify = require 'restify'
zSchema = require	'z-schema'
generator = require './generator'

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
					result = generator.generate schema.error or {}
					result.schema_error = '你丫臭不要脸!居然强行让请求失败!'
					res.send errorCode, result
				# schema验证
				zSchema.validate(json, schema.params).then((report) ->
					# 通过验证 根据success schema 生成返回数据
					result = generator.generate schema.success or {}
					res.send 200, result
				).catch (err) ->
					# 没有通过验证 根据error schema 生成返回数据
					result = generator.generate schema.error or {}
					# 添加验证失败的原因 方便查看
					result.schema_error = err.errors
					# console.error err
					res.send errorCode, result

	server.listen port, ->
		console.info "############# \n #{server.name} listening at #{port} ... \n#############"

module.exports =
	create: create