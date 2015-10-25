#! /usr/bin/env coffee

args      = require '../src/args'
templates = require '../src/templates'

args
  .withDefaultOptions 'template', 'template-jade', 'template-data'
  .describe 'template', 'The saved template to show'
  .describe 'template-data', 'The jade template to show'
  .describe 'template-jade', 'The saved template data to show'

args = args.camelize()

templates.show args.template, args.templateJade, args.templateData