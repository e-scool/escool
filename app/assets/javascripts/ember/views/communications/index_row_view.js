App.CommunicationsIndexRowView = Ember.View.extend({
  templateName: 'communications/index_row',
  tagName: 'li',
  classNames: ['communication'],

  click: function() {
    this.get('controller').send('goToShow');
  }
});