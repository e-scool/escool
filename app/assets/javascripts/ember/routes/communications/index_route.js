App.CommunicationsIndexRoute = Ember.Route.extend({
  model: function() {
    return this.get('store').find('communication');
  },

  exit: function() {
    this.get('controller').set('newFormDisplayed', false);
  }
});