#! /usr/bin/env coffee

args      = require('../src/args').camelized 'template'
templates = require '../src/templates'

templates.show args.template