// For more information see: http://emberjs.com/guides/routing/

App.Router.map(function() {
  this.resource('dashboard', {path: '/'});
  this.resource('communications', function() {
    this.route('index', {path: '/'});
    this.route('show', {path: '/:communication_id'});
  });
  this.resource('materials', function() {
    this.route('index', {path: '/'});
    this.route('show', {path: '/:material_id'});
  });
});

App.Router.reopen({
  rootURL: '/dashboard/'
});

App.Route = Ember.Route.extend({
  afterModel: function() {
    $("body").animate({'scrollTop': 0});
    return this._super.apply(this, arguments);
  }
});