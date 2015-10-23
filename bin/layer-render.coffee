#! /usr/bin/env coffee

args = require('../src/args').withDefaultOptions().camelize()
Layer = require '../src/layer'

layer = new Layer args
layer.updateBackground args.template