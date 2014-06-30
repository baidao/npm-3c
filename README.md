## 简介
* 基于json-s **"c"** hema
* 生成文档do **"c"**
* 生成mo **"c"** k server

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
- demo.js: schema栗子

    简单的schema可以搞定 暂时不支持比较碉堡的 oneOf allOf $ref..等等

    自带一些特殊的format 方便生成测试数据


```
    timestamp: { //自带的匹配 timestamp
        type: 'string',
        format: 'timestamp'
    },
    aaa: { //自定义的特殊匹配
        type: 'string',
        format: 'aaaaaaa'
    }
```

```
'datetime':
    val: new Date _.random(1400000000000, 1800000000000)
  'timestamp': ->
    val: _.random 1400000000000, 1800000000000
  'email':
    pattern: /\w{3,6}\.example\.com\/\w{3,6}/
  'uri':
    pattern: /\http:\/\/\w{3,6}\.example\.com\/\w{3,6}/
  'mobile':
    pattern: /^18\d{5,9}/
```

也可以自行 在format.js 添加

#### format: 存放特殊的匹配规则

对pattern匹配的一个补充

用来生成Mock数据

- format.js

```
module.exports = {
    woshinibaba: {
        val: 'woshinibaba' //直接采用 数据
    },
    aaaaaaa: {
        pattern: "[a-c]" //按照pattern 生成数据
    }
};
```

### 生成文档
> 3c -d 或者 3c --doc

按照schema 目录下的配置文件和json-schema文件 生成api文档

### 启动mock server

> 3c -m 或者 3c --mock

## Todos

> 3c -c 或者 3c --check

对服务器返回数据的校验...


## Hava fun!
