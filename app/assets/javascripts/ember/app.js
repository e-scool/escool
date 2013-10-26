//= require handlebars
//= require ember
//= require ember-data

//= require_self

//= require ./store
//= require ./router
//= require_tree ./routes
//= require_tree ../templates
//= require_tree ./mixins
//= require_tree ./models
//= require_tree ./controllers
//= require_tree ./views
//= require_tree ./helpers
//= require_tree ./components

(function (exports) {
  exports.App = Ember.Application.create({
    rootElement: '#ember-application'
  });
})(window);