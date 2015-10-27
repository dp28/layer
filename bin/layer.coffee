#! /usr/bin/env coffee

program = require 'yargs'

subcommand = (name, description) ->
  program.command name, description, -> require "./layer-#{name}"

program
  .usage 'Usage: layer <command> [options]'
  .help  'help'
  .alias 'h', 'help'

subcommand 'config', 'Show or set global configuration'
subcommand 'render', 'Render a template to the terminal background'
subcommand 'delete', 'Delete a saved template (does not remove the files)'
subcommand 'list',   'List the names of all saved templates'
subcommand 'show',   'Print a template and its data to the console'
subcommand 'new',    'Save a jade file and json file as a new template'

program.argv

program.showHelp() if process.argv.length is 2
