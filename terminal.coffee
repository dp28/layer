spawn = require('child_process').spawn

module.exports = getSize: (callback) ->
  spawn('resize').stdout.on 'data', (data) ->
    data    = String data
    lines   = data.split '\n'
    columns = +lines[0].match(/^COLUMNS=([0-9]+);$/)[1]
    rows    = +lines[1].match(/^LINES=([0-9]+);$/)[1]
    callback? columns, rows
