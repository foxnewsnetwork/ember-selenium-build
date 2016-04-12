path = require "path"
RSVP = require "rsvp"
asyncMap = require "../utils/async-map"
Writer = require "./writer"
chromedriver = require('chromedriver')
{Builder, By, until: Until} = require('selenium-webdriver')

wait = (time) ->
  new RSVP.Promise (r) -> setTimeout r, time

class Machine
  instance = null
  @setupBuilder = (flavor) ->
    switch flavor
      when "chrome"
        {Options} = require('selenium-webdriver/chrome')
        chromeOptions = new Options()
        chromeOptions.addArguments ['--incognito']
        new Builder()
        .forBrowser('chrome')
        .setChromeOptions(chromeOptions)
      else throw new Error "Sorry, currently only 'chrome' is supported"
  
  @setupDriver = (flavor) ->
    @setupBuilder flavor
    .buildAsync()

  @instance = -> instance
  
  @initialize = ({flavor, baseURI, outPath, routes}) ->
    @setupDriver flavor
    .then (driver) ->
      instance = new Machine(driver, baseURI, routes, outPath)

  constructor: (@driver, @baseURI, @routes, outPath) ->
    @writer = new Writer(outPath)

  write: (string) -> @writer.write(string)

  quit: -> @driver.quit()

  build: ->
    asyncMap @routes, @generatePage.bind(@)

  finishBuild: ->
    @build().then @quit.bind(@)

  generatePage: (route) ->
    @driver
    .get @calculateURI route
    .then =>
      @driver.wait @until.titleMatches(/~ok$/), 1000
    .then =>
      wait 1500
    .then =>
      @driver.getPageSource()
    .then (source) =>
      @write(source).intoFile(@calculateFilename route)

  calculateURI: (route) ->
    path.normalize path.join(@baseURI, route)

  calculateFilename: (route) ->
    endsInSlash = /\/$/
    switch
      when endsInSlash.exec(route)? then path.join(route, "index")
      else route

module.exports = Machine