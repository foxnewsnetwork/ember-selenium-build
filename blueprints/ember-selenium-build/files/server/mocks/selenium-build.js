/*jshint node:true*/
module.exports = function(app) {
  var seleniumBrowser = require("ember-selenium-build");
  var express = require('express');
  var seleniumBuildRouter = express.Router();

  // informs the server the app has loaded
  seleniumBuildRouter.get('/:id', function(req, res) {
    if (typeof seleniumBrowser !== "undefined" && seleniumBrowser !== null) {
      seleniumBrowser.capture(req.params.id);
    }
    res.send({
      'selenium-build': []
    });
  });

  // The POST and PUT call will not contain a request body
  // because the body-parser is not included by default.
  // To use req.body, run:

  //    npm install --save-dev body-parser

  // After installing, you need to `use` the body-parser for
  // this mock uncommenting the following line:
  //
  //app.use('/api/selenium-build', require('body-parser').json());
  app.use('/api/selenium-build', seleniumBuildRouter);
};
