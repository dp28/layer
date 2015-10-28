#! /usr/bin/env coffee

args           = require '../src/args'
templates      = require '../src/templates'
ObjectAccessor = require '../src/object-accessor'
jsonFile       = require '../src/utils/json-file'

args
  .withDefaultOptions 'template'
  .describe 'template', 'The name of the saved template to print the data for'

  .option 'k',
    requiresArg: true
    alias:       'key'
    type:        'string'
    describe:    'The key chain to the data object/array to print, eg --key ' +
                 'path[2].object'

  .demand ['key']

argv = args.camelize()

dataFile = templates.resolveTemplate(argv.template).data
data     = jsonFile.read dataFile
accessor = new ObjectAccessor
console.log accessor.getValue data, argv.key