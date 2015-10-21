fs   = require 'fs'
path = require 'path'

{ hyphenize, camelize } = require './utils'

class Config

  CONFIG_FILE   = path.join __dirname, '../', 'config.json'

  DEFAULTS:
    'image-file': path.join __dirname, '../', 'output/background.png'

  constructor: ->
    @raw = JSON.parse fs.readFileSync CONFIG_FILE, 'utf8'

  getOptions: ->
    @options ?= buildOptions @raw, @DEFAULTS

  save: ->
    json = JSON.stringify @raw, null, 2
    fs.writeFile CONFIG_FILE, json, (error) ->
      console.log "Failed to save config due to error: #{error}" if error?

  buildOptions = (config, defaults) ->
    options = {}
    options[camelize key] = value ? defaults[key] for key, { value } of config
    options

config = new Config
module.exports = config



