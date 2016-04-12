runCommand = require "ember-cli/tests/helpers/run-command"
fs = require "fs-extra"
chai = require "chai"

chai.use require "chai-files"

{expect, file, dir} = chai

describe.skip "Acceptance: Selenium Build (too slow)", ->
  @timeout(450000)
  before (done) ->
    runCommand "selenium-build:build --output-path test-dist"
    .then done
  after ->
    if fs.existsSync "test-dist"
      fs.rmdirSync "test-dist"
  it "should have created the test-dist dir", ->
    expect(dir "test-dist").to.exist
  it "should have the index file", ->
    expect(file "test-dist/index.html").to.exist
    expect(file "test-dist/index.html").to.not.contain "now-loading-"
  it "should have the install file", ->
    expect(file "test-dist/install.html").to.exist
    expect(file "test-dist/install.html").to.not.contain "now-loading-"
  it "should have the usage file", ->
    expect(file "test-dist/usage.html").to.exist
    expect(file "test-dist/usage.html").to.not.contain "now-loading-"
  it "should have the reqs file", ->
    expect(file "test-dist/reqs.html").to.exist
    expect(file "test-dist/reqs.html").to.not.contain "now-loading-"
    

