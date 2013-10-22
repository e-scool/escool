App.User = DS.Model.extend({
  // Database attrs
  name:     DS.attr('string'),
  username: DS.attr('string')

  // Relations
  // team:                       DS.belongsTo('team'),
  // friends:                    DS.hasMany('user',{async: true}),

  // Properties
  // flagUrl: function(){
  //   var countryName = this.get('countryName');
  //   if (countryName){
  //     return "/assets/flags/"+countryName.replace(' ','_')+".png"
  //   }
  // }.property('countryName'),

  // fullName: function(){
  //   if (this.get('firstName') && this.get('lastName')){
  //     return this.get('firstName') + ' ' + this.get('lastName');
  //   }
  // }.property('firstName','lastName'),

  // isRival: function(){
  //   return currentUserId && this.get('id') != currentUserId;
  // }.property()
});
