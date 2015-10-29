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
    describe:    'The key of the data object/array to remove. For example, ' +
                 '"--key path[2].object" will remove the "object" property ' +
                 'of the third element of the path array.'

  .demand ['key']

argv = args.camelize()

dataFile = templates.resolveTemplate(argv.template).data
data     = jsonFile.read dataFile
accessor = new ObjectAccessor
accessor.remove data, argv.key
jsonFile.write dataFile, data
require './layer-render'