App.CommunicationController = Ember.ObjectController.extend({
  actions: {
    showDetails: function() {
      this.transitionToRoute('communications.show', this.get('id'));
    }
  }
});