App.CommunicationsIndexController = Ember.ArrayController.extend({
  itemController: 'communication',
  sortProperties: ['date'],
  sortAscending: false,

  resetForm: function() {
    this.setProperties({
      'date': null,
      'title': null,
      'body': null
    });
  },

  actions: {
    showNewForm: function() {
      this.set('newFormDisplayed', true);
    },

    hideNewForm: function() {
      this.set('newFormDisplayed', false);
    },

    saveCommunication: function() {
      if (!this.get('loading')) {
        this.set('loading', true);

        var communication = this.get('store').createRecord('communication', {
          date:  moment(this.get('date'), 'DD-MM-YYYY').toDate(),
          title: this.get('title'),
          body:  this.get('body')
        });

        communication.save().then(function() {
          this.set('loading', false);
          this.set('newFormDisplayed', false);
          this.resetForm();
        }.bind(this));
      }
    }
  }
});