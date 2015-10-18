jade     = require 'jade'
render   = require './renderer'
terminal = require './terminal'

module.exports = ->
  template = jade.compileFile './templates/default.jade'
  render 'output/background.png', template test: 'layer'
  terminal.getSize (width, height) -> console.log { width, height }
