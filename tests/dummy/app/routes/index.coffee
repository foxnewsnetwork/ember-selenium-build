`import Ember from 'ember'`

IndexRoute = Ember.Route.extend
  model: ->
    @store.findAll "doc"

`export default IndexRoute`