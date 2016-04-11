defaultPort = process.env.PORT or 4200
Selenium = require("../tasks/selenium")
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

PathOpt =
  name: 'build-routes'
  type: 'Path'
  default: 'ember-selenium-build.js'

module.exports =
  name: "selenium-build:build"
  description: "Pre-renders your app into a bunch of static html pages"
  works: "insideProject"
  availableOptions: [EnvOpt, OutOpt, PathOpt]
  run: (cmdOpts, rawArgs) ->
    Selenium.run cmdOpts
    .then =>
      @ui.write "Your app has been built"
