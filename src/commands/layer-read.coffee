args           = require '../args'
templates      = require '../templates'
ObjectAccessor = require '../object-accessor'
jsonFile       = require '../utils/json-file'

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