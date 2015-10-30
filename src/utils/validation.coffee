chalk     = require 'chalk'
spawnSync = require 'spawn-sync'

module.exports =
  ensureAll: ensureAll
  error:     error

  ensureAllFound: (toFind, source) ->
    ensureAll toFind,
      (arg) -> source[arg]?
      (arg) -> "'--#{arg}' is required"

  ensureCanExecute: ->
    requireTerminalCommand 'phantomjs'
    requireTerminalCommand 'resize'
    requireTerminalCommand 'gconftool-2'

requireTerminalCommand = (command) ->
  unless spawnSync('which', [command]).status is 0
    error "You must have the command '#{command}' to use layer"

error = (message) ->
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