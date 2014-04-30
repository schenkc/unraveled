Unraveled.Views.MessagesIndex = Backbone.View.extend({

  template: JST['messages/index'],

  render: function() {

    var content = this.template({
      messages: this.collection
    });
    this.$el.html(content);
    return this;
  }

});
