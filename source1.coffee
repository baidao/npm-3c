module.exports = [
		title: "test1"
		description: "just for test"
		type: "get"
		params: 
			"type": 'object'
			"properties": 
				"firstName": 
					"type": "string"
				"lastName": 
					"type": "string"
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