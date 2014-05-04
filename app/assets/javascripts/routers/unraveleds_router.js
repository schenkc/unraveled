Unraveled.Routers.MessageRouter = Backbone.Router.extend({
  initialize: function (receivedMessages, sentMessages, friends, $rootEl) {
    this.receivedMessages = receivedMessages;
    this.sentMessages = sentMessages;
    this.friends = friends;
    this.$rootEl = $rootEl;
  },

  routes: {
    '': 'index',
    'new': 'new',
    ':id': "show"
  },

  index: function () {
    var receivedMessagesIndexView = new Unraveled.Views.MessagesIndex({
      inbox: this.receivedMessages,
      outbox: this.sentMessages
    });
    this._swapView(receivedMessagesIndexView);
  },

  show: function(id) {

    var receivedMessageShowView = new Unraveled.Views.MessageShow({
      collection: this._getThread(id)
    });
    this._swapView(receivedMessageShowView);
  },

  new: function(id) {
    // var defaultFriend I want to use the query string to pull the user id to set a default in the drop down
    var newMessage = new Unraveled.Models.Message();
    var formView = new Unraveled.Views.MessageForm({
      collection: this.sentMessages,
      model: newMessage,
      friends: this.friends
    });
    this._swapView(formView)
  },

  _swapView: function (view) {
    this._currentView && this._currentView.remove();
    this._currentView = view;
    this.$rootEl.html(view.render().$el);
  },

  _getMessage: function (id) {
    if ( this.receivedMessages.get(id) ) {
      return this.receivedMessages.get(id);
    } else if ( this.sentMessages.get(id)) {
      return this.sentMessages.get(id);
    };
  },

  _getThread: function(id) {

    var thread = new Unraveled.Collections.Messages();
    var message = this._getMessage(id);

    if (this.receivedMessages.get(id)) {
      thread.push(this.receivedMessages.where({
        sender_id: message.get("sender_id")
      }));
      thread.push(this.sentMessages.where({
        receiver_id: message.get("sender_id")
      }));
    } else if (this.sentMessages.get(id)) {
      thread.push(this.sentMessages.where({
        receiver_id: message.get("receiver_id")
      }));
      thread.push(this.receivedMessages.where({
        sender_id: message.get("receiver_id")
      }));
    }

    thread.sort();
    return thread;
  }
});
