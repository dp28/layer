#! /usr/bin/env coffee

args      = require '../src/args'
templates = require '../src/templates'

args.withDefaultOptions('template')
  .option 'show',
    alias:    's'
    describe: 'Print the raw template jade and data to the console'
    type:     'boolean'

  .option 'new',
    alias:       'n'
    describe:    'Create a new template with the provided name'
    requiresArg: true
    type:        'string'

  .option 'delete',
    alias:       'n'
    describe:    'Delete a reference to a template (not the files themselves)'
    requiresArg: true
    type:        'string'

templates.show args.camelize().template