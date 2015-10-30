path         = require 'path'
expandTilde  = require 'expand-tilde'

pathFromHome = require('./utils/path-from-home').pathFromHome
jsonFile     = require './utils/json-file'

{ hyphenize, camelize } = require './utils/string-helpers'

class Config

  CONFIG_FILE   = pathFromHome 'config.json'
  DEFAULT_IMAGE = path.join expandTilde('~'), '.layer-background.png'

  constructor: ->
    @raw = jsonFile.read CONFIG_FILE
    @raw['image-file'].default ?= DEFAULT_IMAGE

  save: ->
    @raw['image-file'].default = null if @raw['image-file'].default is DEFAULT_IMAGE
    jsonFile.write CONFIG_FILE, @raw

  buildOptions = (config) ->
    options = {}
    options[camelize key] = value.default for key, value of config
    options

config = new Config
module.exports = config



