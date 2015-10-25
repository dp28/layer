#! /usr/bin/env coffee

fs        = require 'fs'
path      = require 'path'
args      = require '../src/args'
templates = require '../src/templates'
ensureAll = require('../src/utils/validation').ensureAll

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

ensureAll templateArgs,
  (arg) -> argv[arg]?
  (arg) -> "'--#{arg}' is required"

args = args.camelize()

jade = path.resolve args.templateJade
data = path.resolve args.templateData

ensureAll [jade, data],
  (file) -> fileExists file
  (file) -> "'#{file}' does not exist"

templates.create args.template, jade, data
