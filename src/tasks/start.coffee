Task = require('ember-cli/lib/models/task')
Machine = require '../models/machine'

module.exports = Task.extend
  run: ({flavor, outputPath, buildRoutes}) ->
    Machine.initialize
      flavor: flavor
      baseURI: "http://localhost:4200"
      outPath: outputPath
      routes: buildRoutes