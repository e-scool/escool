App.ApplicationRoute = Ember.Route.extend({
  model: function () {
    var store = this.get('store');
    return store.find('user', currentUserId);
  }
});