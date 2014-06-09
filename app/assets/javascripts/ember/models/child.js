App.Child = DS.Model.extend({
  parent: DS.belongsTo('user')
});
