Unraveled.Models.Message = Backbone.Model.extend({

  parse: function(json) {
    if (json["receiver"]) {
      this.receiver().set(json["receiver"]);
      delete json["receiver"];
    } else if (json["sender"]) {
      this.sender().set(json["sender"]);
      delete json["sender"];
    }
    return json;
  },

  receiver: function () {
    if (!this.get('receiver')) {
      var friend = new Unraveled.Models.Friend({});
      this.set({
        receiver: friend
      });
    }
    return this.get('receiver');
  },

  sender: function () {
    if(!this.get('sender')) {
      var friend = new Unraveled.Models.Friend({});
      this.set({
        sender: friend
      });
    }
    return this.get('sender');
  }


});