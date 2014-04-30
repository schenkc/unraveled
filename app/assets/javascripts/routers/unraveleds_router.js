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
    console.log("rootEl", this.$rootEl);
    console.log("View", receivedMessagesIndexView)
    this._swapView(receivedMessagesIndexView);
    console.log("new rootEl", this.$rootEl);

  },

  _swapView: function (view) {
    console.log("view", view)
    this._currentView && this._currentView.remove();
    this._currentView = view;
    this.$rootEl.html(view.render().$el);
  }
});
