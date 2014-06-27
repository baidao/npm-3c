module.exports = [
		title: "test2"
		description: "just for test"
		type: "post"
		host: "localhost"
		path: "/test2"
		params: 
			"type": 'object'
			"properties": 
				"age": 
					"description": "Age in years"
					"type": "integer"
					"minimum": 0
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