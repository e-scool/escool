// For more information see: http://emberjs.com/guides/routing/

App.Router.reopen({
  rootURL: '/dashboard'
});

App.Router.map(function() {
  this.resource('communications');
});

App.Route = Ember.Route.extend({
  afterModel: function(){
    $("body").animate({'scrollTop': 0});
    return this._super.apply(this, arguments);
  }
});