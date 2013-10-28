App.ApplicationController = Ember.Controller.extend({
  currentUser: function () {
    return this.get('content');
  }.property()
});