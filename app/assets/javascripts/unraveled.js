window.Unraveled = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    var $rootEl = $('.message');
    var receivedMessages = new Unraveled.Collections.Messages();

    receivedMessages.fetch({
      success: function () {
        console.log(receivedMessages)
        new Unraveled.Routers.MessageRouter(receivedMessages, $rootEl);
        Backbone.history.start();
      },
      error: function () {
        console.log('Failed to fetch.');
      }
    });
  }
};

