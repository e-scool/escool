App.CommunicationsController = Ember.ArrayController.extend({
  needs: ['application'],
  currentUser: Ember.computed.alias('controllers.application.currentUser')
});