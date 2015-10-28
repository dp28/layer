chalk = require 'chalk'

module.exports =
  ensureAll: ensureAll

  ensureAllFound: (toFind, source) ->
    ensureAll toFind,
      (arg) -> source[arg]?
      (arg) -> "'--#{arg}' is required"

  error: (message) ->
    logError message
    process.exit 1

logError = (message) ->
  console.log chalk.red('[Error]'), message

ensureAll = (array, check, generateMessage) ->
  success = true
  for element in array when not check element
    logError generateMessage element
    success = false
  process.exit 1 unless success