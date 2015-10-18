phantom = require 'phantom'

module.exports = (fileName, html) ->
  phantom.create (ph) ->
    ph.createPage (page) ->
      page.set 'content', html
      page.render fileName
      ph.exit()