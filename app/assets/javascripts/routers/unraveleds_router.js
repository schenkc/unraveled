Unraveled.Routers.MessageRouter = Backbone.Router.extend({
  initialize: function (messages, $rootEl) {
    this.messages = messages;
    this.$rootEl = $rootEl;
  },

  routes: {
    '': 'index',
    'new': 'new',
    ':id': "show"
  },

  index: function () {
    var receivedMessagesIndexView = new Unraveled.Views.MessagesIndex({
      collection: this.messages
    });
    this._swapView(receivedMessagesIndexView);
  },

  show: function(id) {
    var receivedMessageShowView = new Unraveled.Views.MessageShow({
      model: this.messages.get(id)
    });
    this._swapView(receivedMessageShowView);
  },

  new: function() {
    var newMessage = new Unraveled.Models.Message();
    var formView = new Unraveled.Views.MessageForm({
      // collection: Unraveled.messages
      model: newMessage
    });
    this._swapView(formView)
  },

  _swapView: function (view) {
    this._currentView && this._currentView.remove();
    this._currentView = view;
    this.$rootEl.html(view.render().$el);
  }
});
