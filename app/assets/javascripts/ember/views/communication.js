App.CommunicationView = Ember.View.extend({
  templateName: 'communications/communication',

  tagName: 'li',

  classNames: ['communication'],
  // classNameBindings: ['classNameFromSize', 'classNameFromMostPopular', 'classNameFromSavings'],

  // classNameFromSize: function () {
  //   return this.get('controller.size');
  // }.property('controller.size'),

  // classNameFromMostPopular: function () {
  //   if (this.get('controller.mostPopular')) {
  //     return 'most-popular';
  //   }
  //   return '';
  // }.property('controller.mostPopular'),

  // classNameFromSavings: function () {
  //   if (this.get('controller.savings') >= 2000) {
  //     return 'big-savings';
  //   }
  // }.property('controller.savings'),
});