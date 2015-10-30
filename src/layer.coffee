fs           = require 'fs'
Promise      = require 'bluebird'
path         = require 'path'
expandTilde  = require 'expand-tilde'

Renderer     = require './renderer'
Terminal     = require './terminal'
jsonFile     = require './utils/json-file'
getTemplate  = require('../src/templates').getCompiled

module.exports = class Layer

  TEMP_IMAGE = path.join expandTilde('~'), '.layer-temp.png'

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
    @renderer.renderToFile(html, file).then =>
      @terminal.replaceBackground file

