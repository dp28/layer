spawn     = require('child_process').spawn
spawnSync = require 'spawn-sync'
Promise   = require 'bluebird'

module.exports = class Terminal

  constructor: (config) ->
    @schema      = "/apps/gnome-terminal/profiles/#{config.profile}/"
    @rowHeight   = config.rowHeight
    @columnWidth = config.columnWidth
    @_forbidScrolling() unless config.allowScroll

  replaceBackground: (fileName) ->
    @_setProperty 'background_image', fileName, 'string'

  getDimensions: -> new Promise (resolve) =>
    spawn('resize').stdout.on 'data', (data) =>
      data    = String data
      lines   = data.split '\n'
      columns = +lines[0].match(/^COLUMNS=([0-9]+);$/)[1]
      rows    = +lines[1].match(/^LINES=([0-9]+);$/)[1]
      resolve
        width:  columns * @columnWidth
        height: rows * @rowHeight

  _forbidScrolling: ->
    @_setProperty 'scroll_background', 'false'

  _setProperty: (name, value, type) ->
    spawnSync 'gconftool-2', ['--set', "#{@schema}#{name}", value, '--type', type]
