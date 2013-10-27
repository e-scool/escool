App.MaterialsRoute = Ember.Route.extend({
  setupController: function (controller) {
    controller.set('model', this.get('store').find('material'));
  }
});