App.ApplicationRoute = Ember.Route.extend({

  actions: {
    goBack: function() {
      history.back();
    }
  }
});
