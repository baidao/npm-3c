'use strict'

_ = require 'underscore'
path = require 'path'
RandExp = require 'randexp'
randexp = RandExp.randexp

# 扩展字符集
RandExp::anyRandChar = ->
  characters = '昨天在电影频道为年轻导演们举办的中国电影新力量活动上谈了一些感受其实后会无期还没公映尚不能称是导演也没资格对所谓年轻人说啥都是说给自己的除了最后一句abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
  characters[_.random characters.length - 1]

# 默认最大值
defaultMax = 20

# 默认匹配格式
defaultFormat =
  'datetime':
    val: new Date _.random(1400000000000, 1800000000000)
  'timestamp': ->
    val: _.random 1400000000000, 1800000000000
  'email':
    pattern: /\w+@example\.com/
  'uri':
    pattern: /\w+\.example\.com\/\w+/
  'mobile':
    pattern: /^18\d{5,9}/

extendFormat = (config) ->
  try
    extension = require path.resolve process.cwd(), config.format
    defaultFormat = _.extend defaultFormat, extension
  catch err
    console.error err, 'extend format...'

genFormat = (key) ->
  format = defaultFormat[key]
  if format
    return format.val if format.val
    return randexp format.pattern if format.pattern
    return randexp /.*/
  else
    return randexp /.*/

# 生成
generate = (schema) ->
  return schema unless _.isObject schema
  return generate.enum schema if schema.enum #枚举
  switch schema.type
    when 'string', 'number', 'integer', 'boolean', 'array', 'object', 'null'
      return generate[schema.type] schema
    else
      if _.isArray schema.type
        return generate.oneOf schema
      if schema.type is 'any' or !schema.type
        return generate.any schema
      console.error "error type: #{schema.type}..."

# enum
generate.enum = (schema) ->
  minimum = 0
  maximum = schema.enum.length - 1
  randomIndex = _.random minimum, maximum
  enumValue = schema.enum[randomIndex]
  generate enumValue

# type = null
generate.null = () ->
  null

# type = boolean
generate.boolean = (schema) ->
  _.random(1) > 0

# type = number / integer
generate.number = generate.integer = (schema) ->
  min = schema.minimum or 0
  max = schema.maximum or defaultMax
  minimum += 1 if schema.exclusiveMinimum
  maximum -= 1 if schema.exclusiveMaximum
  multipleOf = schema.multipleOf or 1
  instance = multipleOf * _.random(min, max)
  if schema.type is 'number' then instance + Math.random() else instance #如果是number 加上随机数

# type = string
generate.string = (schema) ->
  min = Math.max 1, schema.minLength or 0
  max = schema.maxLength or defaultMax
  return randexp(schema.pattern) if schema.pattern #正则
  return genFormat(schema.format) if schema.format #特殊格式化
  randexp ".{#{min},#{max}}"

# type = array
generate.array = (schema) ->
  minItems = schema.minItems or 0
  maxItems = schema.maxItems or defaultMax
  instance = []
  amount = undefined
  items = undefined
  i = undefined
  newItem = undefined
  if schema.items
    items = schema.items
    if _.isArray items
      amount = _.random minItems, Math.min(maxItems, items.length)
      instance = _.map items.slice(0, amount), (subschema) ->
        generate subschema method, depth
      while instance.length < minItems
        if _.isObject schema.additionalItems
          newItem = generate schema.additionalItems
        else
          newItem = null
        instance = instance.concat newItem
    else #一般情况
      amount = _.random minItems, maxItems
      i = 0
      while i < amount
        instance[i] = generate items
        i++
  instance

# type = object
generate.object = (schema) ->
  instance = {}
  min = schema.minProperties or 0
  max = schema.maxProperties or defaultMax
  required = schema.required or []
  properties = schema.properties or {}
  remaining = _.keys properties
  _.each required, (name) -> instance[name] = generate schema.properties[name]
  remaining = _.difference remaining, required
  amount = _.random(Math.max(min, required.length), max) - required.length
  _.each remaining.slice(0, amount), (name) -> instance[name] = generate schema.properties[name]
  instance

# type = any
generate.any = (schema) ->
  types = ['string', 'number', 'integer', 'boolean', 'object', 'null']
  typeIndex = _.random 0, types.length - 1
  generate {type: types[typeIndex]}

# type = []
generate.oneOf = (schema) ->
  return 0 unless schema.type.length # treat as 'any'
  typeIndex = _.random 0, schema.type.length - 1
  generate {type: schema.type[typeIndex]}

# 只支持简单格式的json schema...
# 暂时不支持如allOf oneOf $ref....
module.exports =
  extend: extendFormat
  generate: generate
