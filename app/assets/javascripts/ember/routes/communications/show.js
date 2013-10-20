App.CommunicationsShowRoute = App.Route.extend({
  controllerName: 'communication',
  model: function (params) {
    return this.get('store').find('communication', params.communication_id);
  },
  actions: {
    close: function(){
      this.transitionTo('communications.index');
    }
  }
});