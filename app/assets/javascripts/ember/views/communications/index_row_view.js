App.CommunicationsIndexRowView = Ember.View.extend({
  templateName: 'communications/index_row',
  tagName: 'tr',
  classNames: ['communication'],

  click: function() {
    this.get('controller').send('showDetails');
  }
});