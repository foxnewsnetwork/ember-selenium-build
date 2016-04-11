import DS from 'ember-data';

const Doc = DS.Model.extend({
  name: DS.attr("string")
});

Doc.reopenClass({
  FIXTURES: [
    {id: "morning-haze", name: "decide"},
    {id: "kuroneko", name: "starcrew"}
  ]
});
export default Doc;
