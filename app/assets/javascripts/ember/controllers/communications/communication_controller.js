App.CommunicationController = Ember.ObjectController.extend({
  actions: {
    goToShow: function() {
      this.transitionToRoute('communications.show', this.get('id'));
    }
  }
});