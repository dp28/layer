fs       = require 'fs'
jade     = require 'jade'
path     = require './utils/path-from-home'
jsonFile = require './utils/json-file'
error    = require './utils/error'

module.exports =
  save: ->
    jsonFile.write TEMPLATES_FILE, TEMPLATES

  getCompiled: (name) ->
    compile resolvePaths findTemplate name

  show: (name) ->
    template = resolvePaths findTemplate name
    printFile template.jade, 'Jade Template'
    printFile template.data, 'Data'

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

printFile = (filePath, label) ->
  labelBorder = Array(label.length + 1).join '-'
  console.log [labelBorder, label, labelBorder].join '\n'
  console.log fs.readFileSync filePath, 'utf-8'
