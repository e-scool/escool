App.User = DS.Model.extend({
  // Database attrs
  name:     DS.attr('string'),
  username: DS.attr('string'),
  type:     DS.attr('string'),

  // Relations
  // team:                       DS.belongsTo('team'),
  // friends:                    DS.hasMany('user',{async: true}),

  // Properties
  isParent: function(){
    return this.get('type') == 'Parent';
  }.property(),

  isTeacher: function(){
    return this.get('type') == 'Teacher';
  }.property(),

  isSchoolManager: function(){
    return this.get('type') == 'SchoolManager';
  }.property()
});
