chalk = require 'chalk'

currentDefault = require('../config').raw.template.default

for name in require('../templates').all_names().sort()
  console.log if name is currentDefault
    chalk.green "#{name} [default]"
  else
    name

