#! /usr/bin/env coffee

args           = require '../src/args'
templates      = require '../src/templates'
ObjectAccessor = require '../src/object-accessor'
jsonFile       = require '../src/utils/json-file'
ensureAllFound = require('../src/utils/validation').ensureAllFound

args
  .withDefaultOptions 'template'
  .describe 'template', 'The name of the saved template to change the data for'

  .option 'k',
    describe:    'The key chain to the data object/array to update, eg path[2].object'
    requiresArg: true
    alias:       'key'
    type:        'string'

  .option 'v',
    describe:    'The value to insert in the key. Values are parsed as JSON.'
    requiresArg: true
    alias:       'value'
    type:        'string'

argv = args.camelize()

ensureAllFound ['key', 'value'], argv
dataFile = templates.resolveTemplate(argv.template).data
data     = jsonFile.read dataFile
accessor = new ObjectAccessor
accessor.setValue data, argv.key, argv.value
jsonFile.write dataFile, data