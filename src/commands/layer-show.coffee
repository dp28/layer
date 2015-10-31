args      = require '../args'
templates = require '../templates'

args
  .withDefaultOptions 'template'
  .describe 'template', 'The saved template to show'

args = args.camelize()

templates.show args.template