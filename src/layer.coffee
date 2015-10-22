fs       = require 'fs'
Promise  = require 'bluebird'

Renderer     = require './renderer'
Terminal     = require './terminal'
jsonFile     = require './utils/json-file'
pathFromHome = require('./utils/path-from-home').pathFromHome
getTemplate  = require('../src/templates').getCompiled

module.exports = class Layer

  TEMP_IMAGE = pathFromHome '/output/temp.png'

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
      fs.unlink TEMP_IMAGE
      @_replace html, @config.imageFile

  _replace: (html, file) ->
    @renderer.renderToFile(html, file).then =>
      @terminal.replaceBackground file

