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
    parent        = getValueFromAccessors object, accessors
    parent[child] = parseValue value

  appendValue: (object, key, value) ->
    accessors     = @parse key
    child         = accessors.pop()
    parent        = getValueFromAccessors object, accessors
    parent[child] = append parent[child], parseValue value

  getValue: (object, key) ->
    getValueFromAccessors object, @parse key

  remove: (object, key) ->
    accessors     = @parse key
    child         = accessors.pop()
    parent        = getValueFromAccessors object, accessors
    if parent instanceof Array and isNumeric child
      parent[child..child] = []
    else
      delete parent[child]

  getValueFromAccessors = (object, accessors) ->
    for accessor in accessors
      object = object[accessor]
      error "#{object} has no property #{accessor}" unless object?
    object

  parseValue = (string) ->
    try
      JSON.parse string
    catch e
      string

  append = (object, toAppend) ->
    return toAppend unless object?
    if object instanceof Array then object.push toAppend else object += toAppend
    object

  isNumeric = (string) ->
    not isNaN(string) and isFinite string
