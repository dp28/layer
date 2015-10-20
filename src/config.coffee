fs   = require 'fs'
path = require 'path'

class Config

  CONFIG_FILE = path.join __dirname, '../', 'config.json'

  constructor: ->
    @data = JSON.parse fs.readFileSync CONFIG_FILE, 'utf8'
    @data.imageFile ?= path.join __dirname, '../', 'output/background.png'

  save: ->
    json = JSON.stringify @data, null, 2
    fs.writeFile CONFIG_FILE, json, (error) ->
      console.log "Failed to save config due to error: #{error}"

config = new Config
module.exports = config



