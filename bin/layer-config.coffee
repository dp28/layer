#! /usr/bin/env coffee

yargs  = require 'yargs'
config = require '../src/config'

{ hyphenizeKeys, hyphenize } = require '../src/utils'

options =
  'allow-scroll': 'Allow the terminal image to scroll when the foreground scrolls'
  'column-width': 'The width of a terminal column in pixels'
  'image-file':   'Where to save the background image'
  'profile':      'The gnome terminal profile to set the background for'
  'row-height':   'The height of a terminal rowin pixels'

for option, description of options
  yargs.option option, describe: description, requiresArg: true

yargs
  .help   'help'
  .alias  'h', 'help'

args = yargs.argv

if process.argv.length is 3 # No arguments other than subcommand
  console.log "--#{key}\t#{value}" for key, value of hyphenizeKeys config.data
else
  for key of config.data
    value = args[hyphenize key]
    config.data[key] = value if value?

  config.save()

