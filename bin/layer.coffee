#! /usr/bin/env coffee

program = require 'yargs'

subcommand = (name, description) ->
  program.command name, description, -> require "./layer-#{name}"

program
  .usage 'layer <command> [options]'
  .help 'help'
  .alias 'h', 'help'

subcommand 'config', 'Show or set global configuration'
subcommand 'render', 'Render a template to the terminal background'

program.argv

