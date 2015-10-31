yargs     = require 'yargs'
config    = require './config'
templates = require './templates'

{ camelizeKeys } = require './utils/string-helpers'

module.exports = yargs

yargs
  .help  'help'
  .alias 'h', 'help'

yargs.withDefaultOptions = (options...) ->
    buildArgs @, options
    @

yargs.camelize = ->
    camelizeKeys @argv

buildArgs = (args, options) ->
  addOptions args, options

addOptions = (args, only) ->
  argv = args.argv
  for option, values of config.raw when only.length is 0 or option in only
    continue if argv[option]?
    params = {}
    params[key] = value for key, value of values

    if typeof params.default is 'boolean'
      params.default = undefined
      params.type = 'boolean'
    else
      params.requiresArg = true

    if params.alias?.length is 1
      shortOption  = params.alias
      params.alias = option
      option       = shortOption

    args.option option, params
