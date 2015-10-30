path = require('../utils/path-from-home').pathFromHome

require('fs').readFile path('./completion.sh'), 'utf-8', (error, data) ->
  console.log data