#! /usr/bin/env coffee

config = require '../src/config'
yargs  = require 'yargs'

yargs
  .option 'profile',
    describe: 'The gnome terminal profile to set the background for'
    type:     'string'
  .option 'allow-scroll', describe: 'Allow the terminal image to move on scroll'
  .option 'row-height',   describe: 'The height of a terminal row'
  .option 'column-width', describe: 'The width of a terminal column'
  .option 'image-file',   describe: 'Where to save the background image'
  .help   'help'
  .alias  'h', 'help'
  .argv
