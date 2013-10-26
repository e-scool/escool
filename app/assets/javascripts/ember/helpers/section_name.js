// Helper that outputs section name with correct translation
//
Ember.Handlebars.registerBoundHelper('sectionName', function(section){
  var key = 'sections.' + section;
  return I18n.t(key);
});
