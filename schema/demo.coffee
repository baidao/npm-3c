'use strict'

module.exports = [
		meta:
			title: 'test2' #接口名
			description: 'just for test2' #描述
			host: 'localhost' #Host
			uri: '/test2' #path
			method: 'delete' #方法类型
		params: #请求参数 get query post data...
			type: 'object'
			properties:
				token:
					type: 'string'
			required: ['token']
		success: #访问成功
			type: 'object'
			required: ['aaaaaaa', 'woshinibaba', 'name', 'email', 'time', 'mobile', 'mobile', 'hobby']
			properties:
				aaaaaaa:
					type: 'string'
					format: 'aaaaaaa'
				woshinibaba:
					type: 'string'
					format: 'woshinibaba'
				name:
					type: 'string'
				email:
					type: 'string'
					format: 'email'
				time:
					type: 'string'
					format: 'timestamp'
				mobile:
					type: 'string'
					format: 'mobile'
				hobbies:
					type: 'array'
					minItems: 8
					maxItems: 10
					items:
						type: 'object'
						required: ['id']
						properties:
							id:
								type: 'integer'
							name:
								type: 'string'
				desc:
				 	type: 'string'
				 	pattern : "[A-Z]"
				level:
				 	type: 'string'
				 	enum: ['中', '高', '低']
				integer:
					type: 'integer'
					minimum: 8888
					maximum: 9999
				number:
					type: 'number'
				bool:
				 	type: 'boolean'
				null:
					type: 'null'
				any:
				 	type: 'any'
		error: #访问失败
			type: 'object'
			properties:
				code:
					type: 'integer'
				msg:
					type: 'string'
			required: ['code']
	]