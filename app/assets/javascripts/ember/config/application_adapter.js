// Ember-data configuration
App.ApplicationAdapter = DS.ActiveModelAdapter.extend({
  namespace: 'api',
  bulkCommit: true,
  pathForType: function(type) {
    var underscored = Ember.String.underscore(type);
    return Ember.String.pluralize(underscored);
  }
});