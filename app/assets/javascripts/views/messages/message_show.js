Unraveled.Views.MessageShow = Backbone.View.extend({

  template: JST['messages/show'],

  render: function() {

    var content = this.template({
      thread: this.collection
    });
    this.$el.html(content);
    return this;
  }

});