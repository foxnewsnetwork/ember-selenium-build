Selenium = require("../tasks/selenium")
path = require "path"
defaultPort = process.env.PORT or 4200
EnvOpt =
  name: 'environment'
  type: String
  default: 'production'
  aliases: ['e', { 'dev': 'development' }, { 'prod': 'production' }] 

OutOpt = 
  name: 'output-path'
  type: 'Path'
  default: 'selenium-dist/'
  aliases: ['op', 'out']

StdOpt =
  name: "std-out"
  type: Boolean
  default: false

PathOpt =
  name: 'build-routes'
  type: 'Path'
  default: 'ember-selenium-build.js'

FlavorOpt =
  name: "flavor"
  type: String
  default: "chrome"

HostOpt =
  name: "host"
  type: String
  default: "localhost:4200"

PortOpt =
  name: "port"
  type: Number
  default: defaultPort

module.exports =
  name: "selenium-build:build"
  description: "Pre-renders your app into a bunch of static html pages"
  works: "insideProject"
  availableOptions: [EnvOpt, OutOpt, PathOpt, FlavorOpt, StdOpt, HostOpt, PortOpt]
  run: (cmdOpts, rawArgs) ->
    root = @project.root
    cmdOpts.buildRoutes = require path.join(root, cmdOpts.buildRoutes)

    new Selenium 
      ui: @ui
      analytics: @analytics
      project: @project
    .run cmdOpts
    .then =>
      @ui.write "Your app has been built"
