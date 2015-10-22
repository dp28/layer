pathFromHome = require('./utils/path-from-home').pathFromHome
jsonFile     = require './utils/json-file'

{ hyphenize, camelize } = require './utils/string-helpers'

class Config

  CONFIG_FILE   = pathFromHome 'config.json'
  DEFAULT_IMAGE = pathFromHome 'output/background.png'

  constructor: ->
    @raw = jsonFile.read CONFIG_FILE
    @raw['image-file'].value ?= DEFAULT_IMAGE

  getOptions: ->
    @options ?= buildOptions @raw

  save: ->
    @raw['image-file'].value = null if @raw['image-file'].value is DEFAULT_IMAGE
    jsonFile.write CONFIG_FILE, @raw

  buildOptions = (config) ->
    options = {}
    options[camelize key] = value for key, { value } of config
    options

config = new Config
module.exports = config



