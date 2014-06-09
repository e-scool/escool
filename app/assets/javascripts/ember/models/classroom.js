App.Classroom = DS.Model.extend({
  teachers: DS.hasMany('user', { async: true })
});
