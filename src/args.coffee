yargs  = require 'yargs'
config = require './config'

{ camelizeKeys } = require './utils/string-helpers'

module.exports = yargs

yargs.withDefaultOptions = (options...) ->
    buildArgs @, options
    @

yargs.camelize = ->
    camelizeKeys @argv

buildArgs = (args, options) ->
  addOptions args, options
  args
    .help  'help'
    .alias 'h', 'help'

addOptions = (args, only) ->
  for option, params of config.raw when only.length is 0 or option in only
    if typeof params.default is 'boolean'
      params.default = undefined
      params.type = 'boolean'
    else
      params.requiresArg = true

    args.option option, params
