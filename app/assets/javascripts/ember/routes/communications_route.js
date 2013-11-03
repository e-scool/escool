App.CommunicationsRoute = Ember.Route.extend({
  model: function () {
    return this.get('store').find('communication');
  }
});