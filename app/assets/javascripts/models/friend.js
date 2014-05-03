Unraveled.Models.Friend = Backbone.Model.extend({
  
  showName: function() {
    return this.get('name') ? this.get('name') : this.get('email')
  }
});