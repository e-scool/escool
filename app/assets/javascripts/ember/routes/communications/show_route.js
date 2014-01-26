App.CommunicationsShowRoute = Ember.Route.extend({
  model: function(params) {
    return this.get('store').find('communication', params.communication_id);
  }
});