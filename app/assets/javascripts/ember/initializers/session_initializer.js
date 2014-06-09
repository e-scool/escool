(function(App){
  Ember.MODEL_FACTORY_INJECTIONS = true;

  var userId = $("meta[name=user-id]").attr("content");

  var Session = Ember.Object.extend(Ember.PromiseProxyMixin, {
    user: Ember.computed.alias('content')
  });

  var classroomCookie = 'escool_current_classroom_id';
  var childCookie = 'escool_current_child_id';

  var setCookie = function(key, value) {
    return $.cookie(key, value, { expires: 30 });
  };

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
          if (user.get('isParent')) {
            user.get('children').then(function(children) {
              if (!$.cookie(childCookie)) {
                setCookie(childCookie, children.get('firstObject.id'));
              }

              user.set('currentChild', store.find('child', $.cookie(childCookie)));
              resolve(user);
            });
          } else {
            user.get('classrooms').then(function(classrooms) {
              if (!$.cookie(classroomCookie)) {
                setCookie(classroomCookie, classrooms.get('firstObject.id'));
              }

              user.set('currentClassroom', store.find('classroom', $.cookie(classroomCookie)));
              resolve(user);
            });
          }
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
      container.lookup('session:main').then(function(user) {
        application.register('user:current', user, { instantiate: false, singleton: true });

        application.inject('controller', 'currentUser', 'user:current');
        application.inject('route',      'currentUser', 'user:current');
        application.inject('model',      'currentUser', 'user:current');
        application.inject('view',       'currentUser', 'user:current');
      });
    }
  });
})(App);
