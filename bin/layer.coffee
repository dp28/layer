#! /usr/bin/env coffee

program = require 'yargs'

subcommand = (name, description) ->
  program.command name, description, -> require "./layer-#{name}"

program
  .usage 'Usage: layer <command> [options]'
  .help  'help'
  .alias 'h', 'help'

subcommand 'append', 'Append data to the saved data for a template'
subcommand 'config', 'Show or set global configuration'
subcommand 'delete', 'Delete a saved template (does not remove the files)'
subcommand 'list',   'List the names of all saved templates'
subcommand 'new',    'Save a jade file and json file as a new template'
subcommand 'read',   'Print a value from within a template to the console'
subcommand 'render', 'Render a template to the terminal background'
subcommand 'show',   'Print a template and its data to the console'
subcommand 'write',  'Write data to the saved data for a template'

program.argv

program.showHelp() if process.argv.length is 2
