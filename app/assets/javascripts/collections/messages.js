Unraveled.Collections.Messages = Backbone.Collection.extend({

  model: Unraveled.Models.Message,
  url: '/api/messages',
  comparator: function(message1, message2) {
    var time1 = message1.get("created_at");
    var time2 = message2.get("created_at");
    if ( time1 < time2 ) {
      return 1;
    } else if ( time1 === time2 ) {
      return 0;
    } else if ( time1 > time2 ) {
      return -1;
    };
  }


});