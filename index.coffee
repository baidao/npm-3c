md = require './lib/markdown'
server = require './lib/server'

if module is require.main 
	# md.write '../config.json'
	server.create '../config.json'