{expect, assert} = require "chai"
Page = require "../../lib/models/page"
Browser = require "../../lib/models/browser"
Writer = require "../../lib/models/writer"


describe "Page", ->
  @timeout 2500
  driver = null
  page = null
  writer = new Writer stdout: true 

  before (done) ->
    Browser.setupDriver "chrome"
    .then (d) ->
      driver = d
    .then ->
      page = new Page 
        driver: driver
        baseURL: "ember-animation.github.io"
        route: "liquid-fire/"
        writer: writer
      done()
  after ->
    driver.quit()

  it "should have a driver", ->
    expect(page).to.have.property("driver")
  it "is the correct object", ->
    expect(page).to.be.an.instanceof(Page)
  it "should have a writer", ->
    expect(page).to.have.property("writer")
  it "should have setup the driver", ->
    expect(driver).to.be.ok
    expect(driver.get).to.be.a "function"
    expect(page.driver).to.equal driver
  it "responds to get", ->
    expect(driver?.get).to.be.a "function"

  describe "#capture()", ->
    # making remote calls here, might take a while
    @timeout 5000
    results = null
    before (done) ->
      page.capture()
      .then (x) ->
        results = x
        done()

    it "should have written the page contents", ->
      expect(results).to.be.ok
    it "should have the proper name", ->
      expect(results?.name).to.equal "liquid-fire/index.html"
    it "should have the actual page content", ->
      expect(results?.content).to.be.ok
      expect(results?.content).to.have.string("Liquid Fire is a toolkit for managing animated transitions")
