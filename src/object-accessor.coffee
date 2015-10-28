error = require('./utils/validation').error

module.exports = class ObjectAccessor

  constructor: ->

  parse: (key) ->
    accessors = []
    keyString = key
    for bracketed in keyString.match(/\[([^\[\]]+)\]/g) ? []
      accessor = '.' + bracketed.replace /['"\[\]]/g, ''
      keyString = keyString.replace bracketed, accessor

    accessors = (part for part in keyString.split '.')

  setValue: (object, key, value) ->
    accessors     = @parse key
    child         = accessors.pop()
    parent        = getValue object, accessors
    parent[child] = JSON.parse value

  getValue = (object, accessors) ->
    console.log object, accessors
    for accessor in accessors
      object = object[accessor]
      error "#{object} has no property #{accessor}" unless object?
    object