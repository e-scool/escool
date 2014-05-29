App.ApplicationSerializer = DS.ActiveModelSerializer.extend({

  serializeHasMany: function(record, json, relationship) {
    var key = relationship.key;
    var json_key = key.singularize().decamelize() + '_ids';

    var relationshipType = DS.RelationshipChange.determineRelationshipType(
      record.constructor, relationship);

    if (relationshipType === 'manyToNone' || relationshipType === 'manyToMany' || relationshipType === 'manyToOne') {
      json[json_key] = Ember.get(record, key).mapBy('id');
    }
  }
});

DS.Transform.reopen({
  camelizeKeys: function(json) {
    var camelizedJson = {};
    var camelizedKey;
    var currentObject;
    var camelizedArray;

    for (var key in json) {
      if (json.hasOwnProperty(key)) {
        camelizedKey = key.camelize();
        currentObject = json[key];

        if (Array.isArray(currentObject)) {
          camelizedArray = [];

          for (var i = 0; i < currentObject.length; i++) {
            camelizedArray.push(this.camelizeKeys(currentObject[i]));
          }

          camelizedJson[camelizedKey] = camelizedArray;
        } else if (typeof currentObject == "object") {
          camelizedJson[camelizedKey] = this.camelizeKeys(currentObject);
        } else {
          camelizedJson[camelizedKey] = currentObject;
        }
      }
    }
    return camelizedJson;
  }
});