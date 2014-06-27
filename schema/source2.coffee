module.exports = [
		meta:
			title: "test2" #接口名
			description: "just for test2" #描述
			host: "localhost" #Host
			uri: "/test2" #path
			method: "get" #方法类型
		params: #请求参数 get query post data...
			"type": "object"
			"properties":
				"token":
					"type": "string"
		success: #访问成功
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
		error: #访问失败
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
	]