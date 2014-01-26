App.CommunicationsIndexController = Ember.ArrayController.extend({
  itemController: 'communication',

  actions: {
    showModal: function() {
      $('.modal-wrapper').addClass('visible');
      $('.modal-content').addClass('visible');
      $('.modal-overlay').css('opacity', '1');
    },

    hideModal: function() {
      $('.modal-overlay').css('opacity', '0');
      $('.modal-content').removeClass('visible');
      $('.modal-wrapper').removeClass('visible');
    },

    addCommunication: function() {
      this.transitionToRoute('materials.index');
    }
  }
});