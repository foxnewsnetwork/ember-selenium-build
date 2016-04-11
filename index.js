/* jshint node: true */
'use strict';

module.exports = {
  name: 'ember-selenium-build',
  includedCommands: function() {
    return {
      'selenium-build:build': require('./lib/commands/build'),
      'selenium-build:init': require('./lib/commands/init'),
    };
  }
};
