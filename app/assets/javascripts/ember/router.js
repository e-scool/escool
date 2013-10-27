// For more information see: http://emberjs.com/guides/routing/

App.Router.map(function () {
  this.resource('dashboard', {path: '/'});
  this.resource('communications');
  this.resource('materials');
});

App.Router.reopen({
  rootURL: '/dashboard/'
});

App.Route = Ember.Route.extend({
  afterModel: function () {
    $("body").animate({'scrollTop': 0});
    return this._super.apply(this, arguments);
  }
});