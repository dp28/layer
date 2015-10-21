#! /usr/bin/env coffee

yargs  = require 'yargs'
config = require '../src/config'

{ hyphenizeKeys, hyphenize } = require '../src/utils'

optionConfig = hyphenizeKeys config.data

yargs
  .help   'help'
  .option 'allow-scroll',
    describe: 'Allow the terminal image to scroll when the foreground scrolls'

options =
  columnWidth: 'The width of a terminal column in pixels'
  rowHeight:   'The height of a terminal row in pixels'
  profile:     'The gnome terminal profile to set the background for'
  imageFile:   'Where to save the background image'

for option, description of options
  yargs.option option,
    describe:    description
    default:     optionConfig[hyphenize option]
    requiresArg: true

args = yargs.argv

if process.argv.length is 3 # No arguments other than subcommand
  yargs.showHelp()
else
  for key of config.data
    value = args[hyphenize key]
    config.data[key] = value if value?

  config.save()

