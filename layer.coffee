jade = require 'jade'

template = jade.compileFile './templates/default.jade', pretty: true

console.log template test: 'layer'