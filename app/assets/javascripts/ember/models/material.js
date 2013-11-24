App.Material = DS.Model.extend({
  title: DS.attr('string'),
  body:  DS.attr('string'),
  date:  DS.attr('date'),

  // Properties
  day: function(){
    return moment(new Date(this.get('date'))).format("DD");
  }.property(),

  month: function(){
    return moment(new Date(this.get('date'))).format("MMMM");
  }.property(),
});