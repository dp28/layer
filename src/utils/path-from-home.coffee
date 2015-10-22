path = require 'path'

HOME = path.join __dirname, '../../'

module.exports =
  pathFromHome: -> path.join HOME, arguments...

  pathResolvingHome: (pathName) ->
    pathName.replace '[LAYER_HOME]', HOME