Task = require('ember-cli/lib/models/task')
Browser = require '../models/browser'

module.exports = Task.extend
  run: ({flavor, outputPath, buildRoutes, stdOut, host, port}) ->
    Browser.initialize
      flavor: flavor
      host: host
      port: port
      outPath: outputPath
      routes: buildRoutes
      stdOut: stdOut