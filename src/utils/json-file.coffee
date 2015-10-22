fs = require 'fs'

module.exports =
  read:  (fileName) ->
    JSON.parse fs.readFileSync fileName, 'utf8'

  write: (fileName, object) ->
    try
      fs.writeFileSync fileName, JSON.stringify object, null, 2
      null
    catch error
      error