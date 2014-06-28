'use strict'

fs = require 'fs'
path = require 'path'
handlebars = require 'handlebars'
handlebars.registerHelper 'json', (obj) ->
   JSON.stringify obj, null, '\t'

create = (config) ->
	# schemas文件
	files = config.files or []
	# 文档文件
	docPath = path.resolve process.cwd(), config.doc or './doc/api.md'
	# 模板文件
	tmplPath = path.resolve __dirname, './templates/md.tpl'
	tmpl = fs.readFileSync tmplPath, 'utf-8'
	try
		# 清空已有文档
		fs.unlinkSync docPath if fs.existsSync docPath
	catch err
		console.log err
	files.forEach (file) ->
		filePath = path.resolve process.cwd(), "./schema/#{file}"
		schemas = require filePath
		try
			# 编译schema 到 md
			doc = handlebars.compile(tmpl)(schemas: schemas)
			fs.appendFileSync docPath, doc
		catch err
			console.error err
	console.info "############# \n api markdown generated at #{docPath} ... \n#############"

module.exports =
	create: create
