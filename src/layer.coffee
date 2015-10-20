jade     = require 'jade'
fs       = require 'fs'
Promise  = require 'bluebird'
path     = require 'path'

Renderer = require './renderer'
Terminal = require './terminal'
config   = require '../config'

TEMP_IMAGE = path.join __dirname, '../', '/output/temp.png'
TEMPLATE   = path.join __dirname, '../', '/templates/default.jade'

module.exports = class Layer

  constructor : ->
    @template = jade.compileFile TEMPLATE
    @terminal = new Terminal config

  updateBackground: ->
    @_buildRenderer().then =>
      @renderer.setContent @template test: 'layer'
      @_switchBackground().then => @renderer.exit()

  _buildRenderer: ->
    @terminal.getDimensions().then (dimensions) =>
      @renderer = new Renderer dimensions

  _switchBackground: ->
    result = @_replace(TEMP_IMAGE).then => @_replace config.imageFile
    result.then => fs.unlink TEMP_IMAGE
    result

  _replace: (file) ->
    @renderer.renderToFile(file).then =>
      @terminal.replaceBackground file
