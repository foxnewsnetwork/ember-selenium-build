Selenium = require "../../lib/tasks/selenium"
{expect, assert} = require "chai"

describe "the selenium build process", ->
  selenium = null
  standardOpts =
    environment: "production"
    outputPath: "test-dist"
    buildRoutes: 'ember-selenium-build.js'
    flavor: "chrome"
  it "should have loaded"
    

