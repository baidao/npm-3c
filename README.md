## 简介
* 生成文档do **"c"**
* 生成mo **"c"** k server
* 校验服务器返回数据**"c"** heck

## 安装

```
(sudo) npm install 3c -g
```

## 使用原则
约定大于配置
尽量按照demo书写
否则不保证..

## 使用
### 初始化
> 3c -i 或者 3c --init

环境初始化 生成对应的3个目录

#### doc: 存放生成的文档

默认是doc/api.md

#### schema: 配置文件和接口json-schema文件
- config.json: 配置文件

```
{
    "files": ["demo"], //接口 schema 文件位置
    "format": "format/format", //特殊匹配规则 文件
    "doc": "doc/api.md", //生成文档位置
    "port": 1234, //mock server端口
    "forceError": false, //是否强制mock server请求失败 并 访问失败的数据
    "errorCode": 500 //mock server请求失败时的http code
}
```
- demo.js: schema例子

    - 简单的schema可以搞定
    - 暂时不支持比较碉堡的 oneOf allOf $ref..等等
    - 可以设置默认值 default

```
module.exports = [
  meta: #接口相关基本藐视
    title: 'test' #接口名称
    description: 'just for test' #接口描述
    host: 'http://localhost:1234'
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
          required: ['id','name']
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

```


### 生成文档
> 3c -d 或者 3c --doc

按照schema 目录下的配置文件和json-schema文件 生成api文档

### 启动mock server

> 3c -m 或者 3c --mock

mock server 默认1234端口

### 数据校验

> 3c -c 或者 3c --check

check server 默认4321端口
浏览器打开 http://localhost:4321
进行校验


## Hava fun!
