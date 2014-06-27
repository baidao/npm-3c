express = require "express"
bodyParser = require "body-parser"
z = require	"z-schema"

create = (filePath) ->
	config = require filePath
	files = config.files
	app = new express
	app.use express.bodyParser()
	app.use app.router
	files.forEach (file) ->
		schemas = require "#{__dirname}/../#{file}"
		schemas.forEach (schema) ->
			type = schema.type.toLowerCase()
			path = schema.path
			app[type] path, (req, res) ->
				json = req.body
				json = req.query if type is 'get'
				z.validate(json, schema.params).then((report) -> 
					res.send "ok"
				).catch((err) ->
					res.send "nop"
				)
	app.listen 1234

module.exports =
	create: create

if module is require.main
	app = new express