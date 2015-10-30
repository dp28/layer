config = require '../config'
args   = require('../args').withDefaultOptions()
argv   = args.argv

if process.argv.length is 3 # No arguments other than subcommand
  args.showHelp()
else
  config.raw[key].default = argv[key] for key of config.raw when argv[key]?
  error = config.save()
  console.log "Failed to save config due to error: #{error}" if error?

