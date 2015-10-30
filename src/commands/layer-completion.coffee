pathFromHome = require '../utils/path-from-home'

COMPLETION_FILE = pathFromHome 'config/completion.sh'

require('fs').readFile COMPLETION_FILE, 'utf-8', (error, data) ->
  console.log data