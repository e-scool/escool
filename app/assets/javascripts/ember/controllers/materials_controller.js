App.MaterialsController = Ember.ArrayController.extend({
  needs: ['application'],
  currentUser: Ember.computed.alias('controllers.application.currentUser'),

  actions: {
    new: function () {
      alert('new action!');
    }

    // buy: function(){
    //   if(App.useFacebookPayments()){
    //     this.send('buyFacebook');
    //   }else{
    //     if(Features.isActive('paymentwall')){
    //       this.send('buyWall');
    //     }else{
    //       this.send('buyAdyen');
    //     }
    //   }
    // },
    // buyMobile: function(){
    //   this.send('buyWall');
    // },

    // buyWall: function(){
    //   this.transitionToRoute('ingotsPackages.show', this.get('content'));
    // },

    // buyFacebook: function(){
    //   var self = this;
    //   ga(function(tracker) {
    //     var clientId = tracker.get('clientId');
    //     window.fbBuyItem(self.get('id'), clientId);
    //   });
    // },

    // buyAdyen: function(){
    //   var id = this.get('id');
    //   ga(function(tracker) {
    //     $.get('/adyen/new_order', {
    //       ingots_package_id: id
    //     }, function (content) {
    //       window.display_fancybox(content);
    //     });
    //   });
    // }
  }
});