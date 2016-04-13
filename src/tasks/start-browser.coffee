Task = require('ember-cli/lib/models/task')
Browser = require '../models/browser'

module.exports = Task.extend
  run: ({flavor, baseURL, outputPath, buildRoutes, stdOut, host, port}) ->
    Browser.initialize
      baseURL: baseURL
      flavor: flavor
      host: host
      port: port
      outPath: outputPath
      routes: buildRoutes
      stdOut: stdOut