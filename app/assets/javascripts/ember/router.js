// For more information see: http://emberjs.com/guides/routing/

App.Router.map(function() {
  this.resource('communications', {path: '/communications'}, function(){
    this.route('show', {path: '/:communication_id'});
  });
});

App.Route = Ember.Route.extend({
  afterModel: function(){
    $("body").animate({'scrollTop': 0});
    return this._super.apply(this, arguments);
  }
});