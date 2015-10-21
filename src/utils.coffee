transformKeys = (transform) -> (object) ->
  result = {}
  result[transform key] = value for key, value of object
  result

camelize = (string) ->
  pieces = string.split /[\W_-]/g
  pieces[0] + (capitalize piece for piece in pieces.slice(1)).join ''

capitalize = (string) ->
  string.charAt(0).toUpperCase() + string.slice(1)

hyphenize = (string) ->
  string.replace(/([A-Z])/g, '-$1').toLowerCase()

camelizeKeys  = transformKeys camelize
hyphenizeKeys = transformKeys hyphenize

module.exports = { camelize, camelizeKeys, capitalize, hyphenize, hyphenizeKeys }