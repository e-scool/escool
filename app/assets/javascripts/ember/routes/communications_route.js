App.CommunicationsRoute = Ember.Route.extend({
  setupController: function (controller) {
    controller.set('model', this.get('store').find('communication'));
  }
});