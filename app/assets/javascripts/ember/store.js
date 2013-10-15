// http://emberjs.com/guides/models/using-the-store/

App.Store = DS.Store.extend({
  Adapter: DS.RESTAdapter.create()
});
