path = require 'path'
script = require '../scripts/injection'

calculateFilename = (route) ->
  endsInSlash = /\/$/
  switch
    when endsInSlash.exec(route)? then path.join(route, "index")
    else route
class Page
  @activePage = null

  @captureSource = (opts) ->
    @activePage = new Page(opts)
    @activePage.capture()

  constructor: ({@driver, @route, @writer, @baseURL}) ->

  injectEmberReadyScript: ->
    @driver.executeAsyncScript script

  pageURL: ->
    "http://" + path.join(@baseURL, @route)

  capture: ->
    @driver.get @pageURL()
    .then =>
      @injectEmberReadyScript()
    .then =>
      @driver.getPageSource()
    .then (source) =>
      @write(source).intoFile(calculateFilename @route)

  write: (string) -> 
    @writer.write(string)

module.exports = Page