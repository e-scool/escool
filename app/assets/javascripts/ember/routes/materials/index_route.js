App.MaterialsIndexRoute = Ember.Route.extend({
  model: function() {
    return this.get('store').find('material');
  }
});