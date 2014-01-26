App.MarerialsShowRoute = Ember.Route.extend({
  model: function(params) {
    return this.get('store').find('material', params.material_id);
  }
});