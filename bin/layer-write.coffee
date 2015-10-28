#! /usr/bin/env coffee

args           = require '../src/args'
templates      = require '../src/templates'
ObjectAccessor = require '../src/object-accessor'
jsonFile       = require '../src/utils/json-file'

args
  .withDefaultOptions 'template'
  .describe 'template', 'The name of the saved template to change the data for'

  .option 'k',
    requiresArg: true
    alias:       'key'
    type:        'string'
    describe:    'The key chain to the data object/array to update, eg --key ' +
                 'path[2].object'

  .option 'v',
    requiresArg: true
    alias:       'value'
    type:        'string'
    describe:    'The value to insert in the key. Values are parsed as JSON, ' +
                 'but fall back to strings if invalid.'

  .demand ['key', 'value']

argv = args.camelize()

dataFile = templates.resolveTemplate(argv.template).data
data     = jsonFile.read dataFile
accessor = new ObjectAccessor
accessor.setValue data, argv.key, argv.value
jsonFile.write dataFile, data
require './layer-render'