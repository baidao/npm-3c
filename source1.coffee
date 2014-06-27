module.exports = [
		title: "test1"
		description: "just for test"
		type: "post"
		host: "localhost"
		path: "/test1"
		params: 
			"type": 'object'
			"properties": 
				"f": 
					"type": "object"
		# 		"lastName": 
		# 			"type": "string"
		# 		"age": 
		# 			"description": "Age in years"
		# 			"type": "integer"
		# 			"minimum": 0
		success: 
			"title": "success"
			"type": "object"
			"properties":
				"firstName": 
					"type": "string"
				"lastName": 
					"type": "string"
				"age": 
					"description": "Age in years"
					"type": "integer"
					"minimum": 0
		error:
			"title": "error"
			"type": "object"
			"properties":
				"firstName": 
					"type": "string"
				"lastName": 
					"type": "string"
				"age": 
					"description": "Age in years"
					"type": "integer"
					"minimum": 0
		other: "ruobi"
	]