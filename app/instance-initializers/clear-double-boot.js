import Ember from 'ember';
import ENV from '../config/environment';
// Taken from ember-fastboot:
// https://github.com/ember-fastboot/ember-cli-fastboot/blob/master/app/instance-initializers/browser/clear-double-boot.js
export function initialize(instance) {
  var ref, originalDidCreateRootView;

  if ((ref = ENV.EmberSeleniumBuild) != null ? ref.dontClearDoubleBoot : void 0) {
    return;
  }

  originalDidCreateRootView = instance.didCreateRootView;
  instance.didCreateRootView = function() {
    Ember.$(instance.rootElement + ' .ember-view').remove();

    originalDidCreateRootView.apply(instance, arguments);
  };
}

export default {
  name: 'clear-double-boot',
  initialize
};
