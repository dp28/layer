fs       = require 'fs'
jade     = require 'jade'
path     = require './utils/path-from-home'
jsonFile = require './utils/json-file'
error    = require './utils/error'

module.exports =
  save: ->
    jsonFile.write TEMPLATES_FILE, TEMPLATES

  getCompiled: (name, jade = null, data = null) ->
    compile resolveTemplate name, jade, data

  show: (name, jade = null, data = null) ->
    template = resolveTemplate name, jade, data
    printFile template.jade, 'Jade Template'
    printFile template.data, 'Data'

  resolveTemplate: -> resolveTemplate arguments...

TEMPLATES_FILE = path.pathFromHome 'templates.json'
TEMPLATES      = jsonFile.read TEMPLATES_FILE

resolveTemplate = (name, jade = null, data = null) ->
  template = findTemplate name
  jade: jade ? path.pathResolvingHome template.jade
  data: data ? path.pathResolvingHome template.data

compile = (template) ->
  compileHtml = jade.compileFile template.jade
  compileHtml jsonFile.read template.data

findTemplate = (name) ->
  template = TEMPLATES[name]
  error "No saved template '#{name}'" unless template?
  template

printFile = (filePath, label) ->
  labelBorder = Array(label.length + 1).join '-'
  console.log [labelBorder, label + ':', filePath, labelBorder].join '\n'
  console.log fs.readFileSync filePath, 'utf-8'
