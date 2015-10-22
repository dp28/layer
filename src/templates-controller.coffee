fs       = require 'fs'
path     = require './utils/path-from-home'
jsonFile = require './utils/json-file'
config   = require('./config').getOptions()

class TemplatesController

  TEMPLATES_FILE = path.pathFromHome 'templates.json'

  constructor: ->
    @templates = jsonFile.read TEMPLATES_FILE

  show: (name = config.defaultTemplate) ->
    template = resolvePaths @templates[name]
    console.log '\n-------------\nJade Template\n-------------'
    console.log fs.readFileSync template.jade, 'utf-8'
    console.log '\n----\nData\n----'
    console.log fs.readFileSync template.data, 'utf-8'

  save: ->
    jsonFile.write TEMPLATES_FILE, @templates

  resolvePaths = (template) ->
    jade: path.pathResolvingHome template.jade
    data: path.pathResolvingHome template.data

module.exports = new TemplatesController