# reference
# https://github.com/ember-cli/ember-cli/blob/master/lib/tasks/serve.js
existsSync = require('exists-sync')
path = require('path')
LiveReloadServer = require('ember-cli/lib/tasks/server/livereload-server')
ExpressServer = require('ember-cli/lib/tasks/server/express-server')
Promise = require('ember-cli/lib/ext/promise')
Task = require('ember-cli/lib/models/task')
Watcher = require('ember-cli/lib/models/watcher')
Builder = require('ember-cli/lib/models/builder')
ServerWatcher = require('ember-cli/lib/models/server-watcher')

module.exports = Task.extend
  run: (options) ->
    builder = new Builder
      ui: @ui
      outputPath: options.outputPath
      project: @project
      environment: options.environment

    watcher = new Watcher
      ui: @ui
      builder: builder
      analytics: @analytics
      options: options

    serverRoot = './server'
    if existsSync(serverRoot)
      serverWatcher = new ServerWatcher
        ui: @ui
        analytics: @analytics
        watchedDir: path.resolve(serverRoot)
    else
      throw new Error "Missing server! ember-selenium-build didn't install right"

    expressServer = new ExpressServer
      ui: @ui
      project: @project
      watcher: watcher
      serverRoot: serverRoot
      serverWatcher: serverWatcher

    # liveReloadServer = new LiveReloadServer
    #   ui: @ui
    #   analytics: @analytics
    #   project: @project
    #   watcher: watcher
    #   expressServer: expressServer

    expressServer.start(options)
