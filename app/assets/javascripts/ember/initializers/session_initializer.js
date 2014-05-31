(function(App){
  Ember.MODEL_FACTORY_INJECTIONS = true;

  var userId = $("meta[name=user-id]").attr("content");

  var Session = Ember.Object.extend(Ember.PromiseProxyMixin, {
    user: Ember.computed.alias('content')
  });

  App.initializer({
    name: 'session',
    after: 'store',

    initialize: function(container, application) {
      application.register('session:main', Session, { singleton: true });

      var session = container.lookup('session:main');
      var store = container.lookup('store:main');
      var user = store.find('user', userId);

      application.deferReadiness();

      var promise = new Ember.RSVP.Promise(function(resolve) {
        user.then(function(user) {
          resolve(user);
        });
      });

      session.set('promise', promise);

      session.then(function() {
        application.advanceReadiness();
      });
    },
  });

  App.initializer({
    name: 'injectSession',
    before: 'session',

    initialize: function(container, application) {
      application.inject('controller', 'session', 'session:main');
      application.inject('route',      'session', 'session:main');
      application.inject('model',      'session', 'session:main');
      application.inject('view',       'session', 'session:main');
    }
  });

  App.initializer({
    name: 'injectCurrentUser',
    after: 'session',

    initialize: function(container, application) {
      container.lookup('session:main').then(function(session) {
        application.register('user:current', session, { instantiate: false, singleton: true });

        application.inject('controller', 'currentUser', 'user:current');
        application.inject('route',      'currentUser', 'user:current');
        application.inject('model',      'currentUser', 'user:current');
        application.inject('view',       'currentUser', 'user:current');
      });
    }
  });
})(App);
