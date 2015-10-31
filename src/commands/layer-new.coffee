fs         = require 'fs'
path       = require 'path'
args       = require '../args'
templates  = require '../templates'
validation = require '../utils/validation'

args
  .withDefaultOptions 'template'
  .describe 'template', 'The name of the new template to save'

  .option 'd',
    alias:       'template-data'
    requiresArg: true
    describe:    'The json file to store data in'
    type:        'string'

  .option 'j',
    alias:       'template-jade'
    requiresArg: true
    describe:    'The jade file to use for this template'
    type:        'string'

args.default 't', undefined

argv = args.argv

fileExists = (filePath) ->
  try
    fs.statSync filePath
    true
  catch e
    false

validation.ensureAllFound ['template', 'template-data', 'template-jade'], argv
args = args.camelize()

jade = path.resolve args.templateJade
data = path.resolve args.templateData

validation.ensureAll [jade, data],
  (file) -> fileExists file
  (file) -> "'#{file}' does not exist"

templates.create args.template, jade, data
