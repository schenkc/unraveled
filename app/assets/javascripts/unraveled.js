window.Unraveled = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    var $rootEl = $('.message');
    var json = JSON.parse($("#bootstrapped-messages").html());
    var receivedMessages = new Unraveled.Collections.Messages(json.receivedMessages, { parse: true });
    var sentMessages = new Unraveled.Collections.Messages(json.sentMessages, { parse: true });
    var friends = new Unraveled.Collections.Friends(json.friends, { parse: true });

    var router = new Unraveled.Routers.MessageRouter(receivedMessages, sentMessages, friends, $rootEl);
    Backbone.history.start();

  }
};

