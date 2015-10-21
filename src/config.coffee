fs   = require 'fs'
path = require 'path'

{ hyphenizeKeys, camelizeKeys } = require './utils'

class Config

  CONFIG_FILE = path.join __dirname, '../', 'config.json'

  constructor: ->
    @data = camelizeKeys JSON.parse fs.readFileSync CONFIG_FILE, 'utf8'
    @data.imageFile ?= path.join __dirname, '../', 'output/background.png'

  save: ->
    json = JSON.stringify hyphenizeKeys(@data), null, 2
    fs.writeFile CONFIG_FILE, json, (error) ->
      console.log "Failed to save config due to error: #{error}" if error?

config = new Config
module.exports = config



