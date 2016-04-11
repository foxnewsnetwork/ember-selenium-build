{expect, assert} = require "chai"
Machine = require "../../src/models/machine"

describe "Selenium Machine sanity", ->
  it "should be present", ->
    expect(Machine).to.be.ok

describe "proper setup and usage", ->
  machine = null
  before (done) ->
    Machine.initialize
      flavor: "chrome"
      baseURI: "http://localhost:4200"
      outPath: "selenium-dist"
      routes: []
    .then (x) -> 
      machine = x
      done()
  after ->
    machine.quit()
  it "should initialize correctly", ->
    expect(machine).to.be.ok
  it "should be a Machine instance", ->
    expect(machine).to.be.a.instanceOf(Machine)
  it "should be stored on the thing itself", ->
    expect(machine).to.be.equal(Machine.instance())
  it "should be able to quit", ->
    expect(machine).to.have.property("quit")