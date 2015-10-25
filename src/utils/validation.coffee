module.exports =
  ensureAll: (array, check, generateMessage) ->
    success = true
    for element in array when not check element
      logError generateMessage element
      success = false
    process.exit 1 unless success

  error: (message) ->
    logError message
    process.exit 1

logError = (message) -> console.log '[Error]', message