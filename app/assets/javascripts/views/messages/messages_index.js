Unraveled.Views.MessagesIndex = Backbone.View.extend({

  template: JST['messages/index'],

  initialize: function(options) {
    this.inbox = options.inbox,
    this.outbox = options.outbox
    },

  render: function() {

    var content = this.template({
      receivedMessages: this.inbox,
      sentMessages: this.outbox
    });

    this.$el.html(content);
    return this;
  }

});
