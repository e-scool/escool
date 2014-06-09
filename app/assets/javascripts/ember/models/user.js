App.User = DS.Model.extend({
  // Database attrs
  name:     DS.attr('string'),
  username: DS.attr('string'),
  type:     DS.attr('string'),

  // Relations
  children:   DS.hasMany('child', { async: true }),
  classrooms: DS.hasMany('classroom', { async: true }),

  // Properties
  isParent: function(){
    return this.get('type') == 'Parent';
  }.property('type'),

  isTeacher: function(){
    return this.get('type') == 'Teacher';
  }.property('type'),

  isSchoolManager: function(){
    return this.get('type') == 'SchoolManager';
  }.property('type')
});
