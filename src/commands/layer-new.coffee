fs         = require 'fs'
path       = require 'path'
args       = require '../args'
templates  = require '../templates'
validation = require '../utils/validation'

templateArgs = ['template', 'template-jade', 'template-data']

args
  .withDefaultOptions templateArgs...
  .describe 'template', 'The name of the new template to save'
  .describe 'template-data', 'The json file to store data in'
  .describe 'template-jade', 'The jade file to use for this template'

args.default arg, undefined for arg in templateArgs

argv = args.argv

fileExists = (filePath) ->
  try
    fs.statSync filePath
    true
  catch e
    false

validation.ensureAllFound templateArgs, argv
args = args.camelize()

jade = path.resolve args.templateJade
data = path.resolve args.templateData

validation.ensureAll [jade, data],
  (file) -> fileExists file
  (file) -> "'#{file}' does not exist"

templates.create args.template, jade, data
