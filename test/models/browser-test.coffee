{expect, assert} = require "chai"
Browser = require "../../lib/models/browser"

describe "Selenium Browser sanity", ->
  it "should be present", ->
    expect(Browser).to.be.ok

describe "proper setup and usage", ->
  browser = null
  before (done) ->
    Browser.initialize
      flavor: "chrome"
      baseURI: "http://localhost:4200"
      outPath: "selenium-dist"
      routes: []
    .then (x) -> 
      browser = x
      done()
  after ->
    browser.quit()
  it "should initialize correctly", ->
    expect(browser).to.be.ok
  it "should be a Browser instance", ->
    expect(browser).to.be.a.instanceOf(Browser)
  it "should be stored on the thing itself", ->
    expect(browser).to.be.equal(Browser.instance)
  it "should be able to quit", ->
    expect(browser).to.have.property("quit")