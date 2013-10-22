// http://emberjs.com/guides/models/using-the-store/

App.Store = DS.Store.extend({
  Adapter: DS.RESTAdapter.create()
});

DS.RESTAdapter.reopen({
  namespace: 'api'
});