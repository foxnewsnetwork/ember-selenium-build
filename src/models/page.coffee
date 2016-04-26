path = require 'path'
url = require 'url'
script = require '../scripts/injection'

class Page
  @activePage = null

  @captureSource = (opts) ->
    @activePage = new Page(opts)
    @activePage.capture()

  constructor: ({@driver, @route, @writer, @baseURL, @port, @host}) ->

  injectEmberReadyScript: ->
    @driver.executeAsyncScript script

  pageURL: ->
    url.format
      hostname: @host
      port: @port
      pathname: path.join(@baseURL, @route)
      protocol: "http"

  capture: ->
    @driver.get @pageURL()
    .then =>
      @injectEmberReadyScript()
    .then =>
      @driver.getPageSource()
    .then (source) =>
      @write(source).intoFile(@route)

  write: (string) -> 
    @writer.write(string)

module.exports = Page