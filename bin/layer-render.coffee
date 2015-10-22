#! /usr/bin/env coffee

yargs  = require 'yargs'
config = require '../src/config'

yargs
  .option 't',
    alias:      'template'
    requiresArg: true
    describe:    'The saved template to render'
    type:        'string'

  .help  'help'
  .alias 'h', 'help'

args = config.merge yargs.argv

Layer = require '../src/layer'
layer = new Layer args
layer.updateBackground args.template