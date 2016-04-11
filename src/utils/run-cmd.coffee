RSVP = require 'rsvp'
{exec} = require "child_process"

runCmd = (cmd, opts) ->
  new RSVP.Promise (resolve, reject) ->
    exec cmd, opts, (err, stdout, stderr) ->
      return reject err if err?
      console.log stdout if stdout?
      console.log stderr if stderr?
      resolve(stdout)

module.exports = runCmd