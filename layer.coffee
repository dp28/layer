jade    = require 'jade'
phantom = require 'phantom'

render = (fileName, html) ->
  phantom.create (ph) ->
    ph.createPage (page) ->
      page.set 'content', html
      page.render fileName
      ph.exit()

template = jade.compileFile './templates/default.jade'
render 'output/background.png', template test: 'layer'
