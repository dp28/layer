args = require('../args').withDefaultOptions().camelize()
Layer = require '../layer'

layer = new Layer args
layer.updateBackground args.template