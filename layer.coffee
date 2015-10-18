jade   = require 'jade'
render = require './renderer'

module.exports = ->
  template = jade.compileFile './templates/default.jade'
  render 'output/background.png', template test: 'layer'
