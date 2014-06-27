fs = require "fs"
path = require "path"
_ = require "underscore"

write = (filePath) ->
	config = require filePath
	schemas = config.files
	outputPath = "#{__dirname}/../docs/api.md"
	try 
		fs.unlinkSync outputPath if fs.existsSync outputPath
	catch e
		console.log e, 'lol'
	schemas.forEach (schema) ->
		schema = require "#{__dirname}/../#{schema}"
		try 		
			fs.appendFileSync outputPath, _.template(fs.readFileSync("#{__dirname}/templates/md.tpl").toString())({schema: schema})
		catch e
			console.log e, 'lol'

module.exports =
	write: write