path       = require 'path'
expandHome = require 'expand-home-dir'

HOME = expandHome '~/.layer'

module.exports = -> path.join HOME, arguments...