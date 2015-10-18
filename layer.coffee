jade   = require 'jade'
render = require './renderer'

template = jade.compileFile './templates/default.jade'
render 'output/background.png', template test: 'layer'
