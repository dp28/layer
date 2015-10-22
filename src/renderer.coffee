Promise = require 'bluebird'

nodePhantom = require('phantom')

module.exports = class Renderer

  constructor: (dimensions) ->
    @page = @_phantom().then (phantom) -> buildPage phantom, dimensions

  renderToFile: (html, fileName) ->
    @page.then (page) ->
      page.set 'content', html
      page.render fileName

  exit: ->
    @_phantom().then (phantom) -> phantom.exit()

  _phantom: ->
    @_phantomInstance ?= new Promise (resolve) ->
      nodePhantom.create (phantom) -> resolve phantom

  buildPage = (phantom, { width, height }) ->
    new Promise (resolve) ->
      phantom.createPage (page) ->
        page.set 'viewportSize', { width, height }
        page.set 'clipRect', { width, height, top: 0, left: 0 }
        resolve page
