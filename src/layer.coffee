fs           = require 'fs'
Promise      = require 'bluebird'
expandHome   = require 'expand-home-dir'

pathFromHome = require './utils/path-from-home'
Renderer     = require './renderer'
Terminal     = require './terminal'
jsonFile     = require './utils/json-file'
getTemplate  = require('../src/templates').getCompiled

module.exports = class Layer

  TEMP_IMAGE = pathFromHome 'temp.png'

  constructor: (@config) ->
    @terminal = new Terminal @config

  updateBackground: (templateName) ->
    @_buildRenderer().then =>
      html = getTemplate templateName
      @_switchBackground(html).then => @renderer.exit()

  _buildRenderer: ->
    @terminal.getDimensions().then (dimensions) =>
      @renderer = new Renderer dimensions

  _switchBackground: (html) ->
    @_replace(html, TEMP_IMAGE).then =>
      fs.unlinkSync TEMP_IMAGE
      @_replace html, @config.imageFile

  _replace: (html, file) ->
    file = expandHome file
    @renderer.renderToFile(html, file).then =>
      @terminal.replaceBackground file

