fs       = require 'fs'
jade     = require 'jade'
path     = require './utils/path-from-home'
jsonFile = require './utils/json-file'
error    = require('./utils/validation').error

module.exports =
  getCompiled: ->
    compile resolveTemplate arguments...

  show: ->
    template = resolveTemplate arguments...
    printFile template.jade, 'Jade Template'
    printFile template.data, 'Data'

  create: (name, jade, data) ->
    templates[name] = { jade, data }
    save()

  delete: (name) ->
    findTemplate name
    delete templates[name]
    save()

  resolveTemplate: -> resolveTemplate arguments...

TEMPLATES_FILE = path.pathFromHome 'templates.json'
templates      = jsonFile.read TEMPLATES_FILE

resolveTemplate = (name, jade = null, data = null) ->
  template = findTemplate name
  jade: jade ? path.pathResolvingHome template.jade
  data: data ? path.pathResolvingHome template.data

compile = (template) ->
  compileHtml = jade.compileFile template.jade
  compileHtml jsonFile.read template.data

findTemplate = (name) ->
  template = templates[name]
  error "No saved template '#{name}'" unless template?
  template

printFile = (filePath, label) ->
  labelBorder = Array(label.length + 1).join '-'
  console.log [labelBorder, label + ':', filePath, labelBorder].join '\n'
  console.log fs.readFileSync filePath, 'utf-8'

save = ->
  jsonFile.write TEMPLATES_FILE, templates
