'use strict'

module.exports = [
  meta:
    title: 'test' #接口名称
    description: 'just for test' #接口描述
    host: 'localhost'
    uri: '/test'
    method: 'get'

  params: #请求参数
    type: 'object'
    properties:
      token:
        type: 'string'
    required: ['token']

  success: #请求成功
    type: 'object'
    required: ['array']
    properties:
      array:
        type: 'array'
        minItems: 8
        maxItems: 10
        items:
          type: 'object'
          required: ['id', 'name']
          properties:
            id:
              type: 'integer'
              description: 'id'
            name:
              type: 'string'
              description: '姓名'
              default: 'hello world'

  error: #请求失败
    type: 'object'
    properties:
      code:
        type: 'integer'
      msg:
        type: 'string'
    required: ['code']
]
