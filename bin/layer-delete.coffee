#! /usr/bin/env coffee

args      = require '../src/args'
templates = require '../src/templates'
ensureAll = require('../src/utils/validation').ensureAll

templateArgs = ['template']

args
  .withDefaultOptions templateArgs...
  .describe 'template', 'The name of the saved template to delete'

args.default arg, undefined for arg in templateArgs

argv = args.argv

ensureAll templateArgs,
  (arg) -> argv[arg]?
  (arg) -> "'--#{arg}' is required"

args = args.camelize()

templates.delete args.template
