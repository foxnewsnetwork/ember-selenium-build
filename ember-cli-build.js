/*jshint node:true*/
/* global require, module */
var EmberAddon = require('ember-cli/lib/broccoli/ember-addon');

module.exports = function(defaults) {
  var app = new EmberAddon(defaults, {
    babel: { includePolyfill: true },
    snippetPaths: ['tests/dummy/app/templates/snippets'],
    'ember-font-awesome': {
      useScss: true, // for ember-cli-sass
    },
    sassOptions: {
      includePaths: [
        'bower_components/material-design-lite/src'
      ]
    }
  });

  /*
    This build file specifies the options for the dummy test app of this
    addon, located in `/tests/dummy`
    This build file does *not* influence how the addon or the app using it
    behave. You most likely want to be modifying `./index.js` or app's build file
  */
  app.import(app.bowerDirectory + '/material-design-lite/material.js');
  return app.toTree();
};
