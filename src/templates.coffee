fs       = require 'fs'
jade     = require 'jade'
path     = require './utils/path-from-home'
jsonFile = require './utils/json-file'
error    = require './utils/error'

TEMPLATES_FILE = path.pathFromHome 'templates.json'
TEMPLATES = jsonFile.read TEMPLATES_FILE

resolvePaths = (template) ->
  jade: path.pathResolvingHome template.jade
  data: path.pathResolvingHome template.data

compile = (template) ->
  compileHtml = jade.compileFile template.jade
  compileHtml jsonFile.read template.data

findTemplate = (name) ->
  template = TEMPLATES[name]
  error "No saved template '#{name}'" unless template?
  template

module.exports =
  save: ->
    jsonFile.write TEMPLATES_FILE, TEMPLATES

  getCompiled: (name) ->
    compile resolvePaths findTemplate name

  show: (name) ->
    template = resolvePaths findTemplate name
    console.log '\n-------------\nJade Template\n-------------'
    console.log fs.readFileSync template.jade, 'utf-8'
    console.log '\n----\nData\n----'
    console.log fs.readFileSync template.data, 'utf-8'