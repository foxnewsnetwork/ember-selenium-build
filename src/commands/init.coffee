module.exports =
  name: "selenium-build:init"
  description: "Setups the server which will handle selenium building"
  works: "insideProject"
  availableOptions: []
    
  run: (cmdOpts, rawArgs) ->
    new @tasks.GenerateFromBlueprint
      ui: @ui
      analytics: @analytics
      project: @project
      testing: @testing
      settings: @settings
    .run 
      args: ["server"]
    
