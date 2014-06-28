'use strict';

module.exports = [
  {
    meta: {
      title: 'test2', //接口名称
      description: 'just for test2', //接口描述
      host: 'localhost',
      uri: '/test2',
      method: 'get'
    },
    params: { //请求参数
      type: 'object',
      properties: {
        token: {
          type: 'string'
        }
      },
      required: ['token']
    },
    success: { //请求成功
      type: 'object',
      required: ['array'],
      properties: {
        array: {
          type: 'array',
          minItems: 8,
          maxItems: 10,
          items: {
            type: 'object',
            required: ['id', 'aaa', 'bbb', 'name', 'email', 'timestamp', 'datetime', 'uri', 'mobile'],
            properties: {
              id: {
                type: 'integer',
                description: 'id'
              },
              any: {
                type: 'any'
              },
              name: {
                type: 'string',
                description: '姓名'
              },
              email: { //自带的匹配
                type: 'string',
                format: 'email',
                description: '邮箱'
              },
              uri: { //自带的匹配 uri
                type: 'string',
                format: 'uri'
              },
              timestamp: { //自带的匹配 timestamp
                type: 'string',
                format: 'timestamp'
              },
              datetime: { //自带的匹配 datetime
                type: 'string',
                format: 'datetime'
              },
              mobile: { //自带的匹配 mobile
                type: 'string',
                format: 'mobile'
              },
              aaa: { //自定义的特殊匹配
                type: 'string',
                format: 'aaaaaaa'
              },
              bbb: { //自定义的特殊匹配
                type: 'string',
                format: 'woshinibaba'
              }
            }
          }
        }
      }
    },
    error: {
      type: 'object',
      properties: {
        code: {
          type: 'integer'
        },
        msg: {
          type: 'string'
        }
      },
      required: ['code']
    }
  }
];