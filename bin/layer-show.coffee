#! /usr/bin/env coffee

args      = require '../src/args'
templates = require '../src/templates'

args
  .withDefaultOptions 'template'
  .describe 'template', 'The saved template to show'

templates.show args.camelize().template