#! /usr/bin/env coffee

yargs  = require 'yargs'
config = require '../src/config'

yargs.help 'help'

for option, { value, description } of config.raw
  params = describe: description
  unless typeof value is 'boolean'
    params.default     = value
    params.requiresArg = true

  yargs.option option, params

args = yargs.argv

if process.argv.length is 3 # No arguments other than subcommand
  yargs.showHelp()
else
  config.raw[key].value = args[key] for key of config.raw when args[key]?
  error = config.save()
  console.log "Failed to save config due to error: #{error}" if error?

