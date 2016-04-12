path = require("path")
fs = require("fs-extra")

class Writer
  constructor: ({@stdout, @base=""}) ->

  write: (@fileContents) -> @

  intoFile: (name) ->
    filename = @makeFileName(name) 
    unless @stdout
      fs.outputFileSync(filename, @fileContents)
    else
      name: filename
      content: @fileContents

  makeFileName: (name) ->
    path.normalize path.join(@base, "#{name}.html")

module.exports = Writer