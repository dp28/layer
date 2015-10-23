#! /usr/bin/env coffee

program = require 'yargs'

subcommand = (name, description) ->
  program.command name, description, -> require "./layer-#{name}"

program
  .usage 'Usage: layer <command> [options]'
  .help  'help'
  .alias 'h', 'help'

subcommand 'config',   'Show or set global configuration'
subcommand 'render',   'Render a template to the terminal background'
subcommand 'template', 'Add, view and edit templates'

program.argv

program.showHelp() if process.argv.length is 2
