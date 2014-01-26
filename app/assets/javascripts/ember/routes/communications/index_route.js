App.CommunicationsIndexRoute = Ember.Route.extend({
  model: function() {
    return this.get('store').find('communication');
  }
});