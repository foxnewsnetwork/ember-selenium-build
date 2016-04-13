# This script gets executed by the chrome browser during build
# Lots of stuff taken from the ember inspector
# https://github.com/emberjs/ember-inspector/blob/master/ember_debug/main.js

exports.module = (..., callback) ->
  Ember = null
  isBlank = null
  run = null
  Application = null

  function tell-selenium-to-begin then callback!

  function when-ember-fully-loads(action)
    check-every 100, "ms", is-ember-fully-loaded, if-so-perform action

  function check-every(time, units, checker, action)
    <- run.later null, _, time
    if checker! then action! else check-every(time, units, checker, action)

  function if-so-perform(action) then action

  function is-ember-fully-loaded
    all-transitions-completed! and all-promises-are-settled!

  function all-promises-are-settled then true

  function all-transitions-completed
    get-router!.activeTransition |> isBlank

  function get-router
    get-container!.lookup("router:main").router

  function get-container
    get-application!.__container__

  function get-application
    for namespace in Application.NAMESPACES when namespace instanceof Application
      return namespace
  
  function when-page-loads(action)
    if window.Ember? 
      action! 
    else 
      window.setTimeout (-> when-page-loads action), 100

  <- when-page-loads
  Ember := window.Ember
  {isBlank, run, Application} := Ember
  when-ember-fully-loads -> tell-selenium-to-begin!