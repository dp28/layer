args           = require '../args'
templates      = require '../templates'
ensureAllFound = require('../utils/validation').ensureAllFound

templateArgs = ['template']

args
  .withDefaultOptions templateArgs...
  .describe 'template', 'The name of the saved template to delete'

args.default arg, undefined for arg in templateArgs

argv = args.argv

ensureAllFound templateArgs, argv
args = args.camelize()

templates.delete args.template
