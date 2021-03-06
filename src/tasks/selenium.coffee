StartBrowser = require "./start-browser"
ServeEmber = require "./serve-ember"
Task = require 'ember-cli/lib/models/task'
{merge} = require 'lodash/object'
RSVP = require 'rsvp'
assign = require('lodash/assign');

# From https://github.com/ember-cli/ember-cli/blob/master/lib/commands/serve.js
#  availableOptions: [
#   { name: 'port',                 type: Number,  default: defaultPort,   aliases: ['p'] },
#   { name: 'host',                 type: String,                          aliases: ['H'],     description: 'Listens on all interfaces by default' },
#   { name: 'proxy',                type: String,                          aliases: ['pr', 'pxy'] },
#   { name: 'insecure-proxy',       type: Boolean, default: false,         aliases: ['inspr'], description: 'Set false to proxy self-signed SSL certificates' },
#   { name: 'watcher',              type: String,  default: 'events',      aliases: ['w'] },
#   { name: 'live-reload',          type: Boolean, default: true,          aliases: ['lr'] },
#   { name: 'live-reload-host',     type: String,                          aliases: ['lrh'],   description: 'Defaults to host' },
#   { name: 'live-reload-base-url', type: String,                          aliases: ['lrbu'],  description: 'Defaults to baseURL' },
#   { name: 'live-reload-port',     type: Number,                          aliases: ['lrp'],   description: '(Defaults to port number within [49152...65535])' },
#   { name: 'environment',          type: String,  default: 'development', aliases: ['e', { 'dev': 'development' }, { 'prod': 'production' }] },
#   { name: 'output-path',          type: 'Path',  default: 'dist/',       aliases: ['op', 'out'] },
#   { name: 'ssl',                  type: Boolean, default: false },
#   { name: 'ssl-key',              type: String,  default: 'ssl/server.key' },
#   { name: 'ssl-cert',             type: String,  default: 'ssl/server.crt' }
# ],

serverOpts =
  insecureProxy: false
  watcher: "events"
  liveReload: false
  ssl: false
  sslKey: "ssl/server.key"
  sslCert: "ssl/server.crt"

module.exports = Task.extend
  run: (browserOptions) ->
    start = new StartBrowser
      ui: @ui
      analytics: @analytics
      project: @project
    serve = new ServeEmber
      ui: @ui
      analytics: @analytics
      project: @project

    options = assign serverOpts, browserOptions,
      baseURL: @project.config(browserOptions.environment).baseURL || '/'

    serve.run(options)
    .then ->
      start.run(options)
    .then (browser) ->
      browser.buildPages()
      .then -> browser.quit()