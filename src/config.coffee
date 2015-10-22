path     = require 'path'
jsonFile = require './utils/json-file'

{ hyphenize, camelize } = require './utils/string-helpers'

class Config

  CONFIG_FILE   = path.join __dirname, '../', 'config.json'

  DEFAULTS:
    'image-file': path.join __dirname, '../', 'output/background.png'

  constructor: ->
    @raw = jsonFile.read CONFIG_FILE

  getOptions: ->
    @options ?= buildOptions @raw, @DEFAULTS

  save: ->
    jsonFile.write CONFIG_FILE, @raw

  buildOptions = (config, defaults) ->
    options = {}
    options[camelize key] = value ? defaults[key] for key, { value } of config
    options

config = new Config
module.exports = config



