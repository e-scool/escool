App.CommunicationsIndexController = Ember.ArrayController.extend({
  itemController: 'communication',

  actions: {
    showNewForm: function() {
      this.set('newFormDisplayed', true);
    },

    hideNewForm: function() {
      this.set('newFormDisplayed', false);
    },

    saveCommunication: function() {

    }
  }
});