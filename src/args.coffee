yargs  = require 'yargs'
config = require './config'

{ camelizeKeys } = require './utils/string-helpers'

module.exports =
  hyphenized: -> buildArgs()
  camelized:  -> camelizeKeys buildArgs(arguments...).argv

buildArgs = (options...) ->
  addOptions options
  yargs
    .help  'help'
    .alias 'h', 'help'

addOptions = (only) ->
  for option, params of config.raw when only.length is 0 or option in only
    if typeof params.default is 'boolean'
      params.default = undefined
    else
      params.requiresArg = true

    yargs.option option, params
