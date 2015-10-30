pathFromHome = require './utils/path-from-home'
jsonFile     = require './utils/json-file'

{ hyphenize, camelize } = require './utils/string-helpers'

class Config

  CONFIG_FILE = pathFromHome 'config.json'

  constructor: ->
    @raw = jsonFile.read CONFIG_FILE

  save: ->
    jsonFile.write CONFIG_FILE, @raw

config = new Config
module.exports = config



