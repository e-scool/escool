// Helper to get I18n translations.
//
Ember.Handlebars.registerHelper('t', function(value, options){
  return I18n.t(value, options.hash).htmlSafe();
});