(function(exports) {
  Ember.RSVP.on('error', function(event) {
    console.error(event.message);
    console.error(event.stack);
  });

  Ember.FEATURES["ember-routing-loading-error-substates"] = true;
  Ember.FEATURES["computed-read-only"] = true;
  Ember.ENV.HELPER_PARAM_LOOKUPS = true;

  exports.App = Ember.Application.create({
    rootElement: '#ember-application',
    LOG_TRANSITIONS: true,

    ready: function() {
      App.setProperties({
        activeSections: window.AppConfig.activeSections
      });
    }
  });

  App.Store = DS.Store.extend({
    cachedFind: function(key, options) {
      var filterFunction;

      if (options) {
        filterFunction = function(element) {
          for (var prop in options) {
            if (element.get(prop.replace(/_id$/, '.id')) !== options[prop]) {
              return false;
            }
            return true;
          }
        };
      }

      var fetchFunction = options ? this.filter(key, options, filterFunction) : this.find(key);
      var cacheFlag     = key + 'Fetched';
      var cachedContent = options ? this.filter(key, filterFunction) : this.all(key);
      var PromiseProxy  = Ember.ObjectController.extend(Ember.PromiseProxyMixin);

      var promise = new Ember.RSVP.Promise(function(resolve) {
        if (this.get(cacheFlag)) {
          resolve(cachedContent);
        } else {
          fetchFunction.then(function() {
            this.set(cacheFlag, true);
            resolve(cachedContent);
          }.bind(this));
        }
      }.bind(this));

      return PromiseProxy.create({
        promise: promise
      });
    }
  });

  // App.deferReadiness();
})(window);
