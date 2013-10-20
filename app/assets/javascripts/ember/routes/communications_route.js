App.CommunicationsRoute = App.Route.extend({
  title: 'Comunicacions',
  model: function () {
    var store = this.get('store');
    this.get('store').find('communication');
    return store.all('communication');
  }
});