path = require "path"
RSVP = require "rsvp"
Writer = require "./writer"
Page = require "./page"
asyncMap = require '../utils/async-map'
Webdriver = require('selenium-webdriver')
Chromedriver = require('chromedriver') # We don't use this, but requiring is necessary
Chrome = require('selenium-webdriver/chrome')
class Browser
  @instance = null
  @setupBuilder = (flavor) ->
    switch flavor
      when "chrome"  
        chromeOptions = new Chrome.Options()
        chromeOptions.addArguments ['--incognito']
        new Webdriver.Builder()
        .forBrowser('chrome')
        .setChromeOptions(chromeOptions)
      else throw new Error "Sorry, currently only 'chrome' is supported"
  
  @setupDriver = (flavor) ->
    @setupBuilder(flavor).buildAsync()
    .then (driver) ->
      driver.manage().timeouts().setScriptTimeout(60000)
      .then -> driver

  @initialize = ({flavor, outPath, routes, stdOut, host, port}) ->
    @setupDriver flavor
    .then (driver) ->
      writer = new Writer base: outPath, stdout: stdOut
      Browser.instance = new Browser(driver, host, port, routes, writer)

  constructor: (@driver, @host, @port, @routes, @writer) ->
    @baseURL = if @port is 80 then @host else "#{@host}:#{@port}"

  buildPages: ->
    asyncMap @routes, @buildPage.bind(@)

  quit: -> @driver.quit()
  
  buildPage: (route) ->
    Page.captureSource
      driver: @driver
      route: route
      writer: @writer
      baseURL: @baseURL

module.exports = Browser