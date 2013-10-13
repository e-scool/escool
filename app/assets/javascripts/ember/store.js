// http://emberjs.com/guides/models/using-the-store/

Escool.Store = DS.Store.extend({
  Adapter: DS.RESTAdapter.create()
});
