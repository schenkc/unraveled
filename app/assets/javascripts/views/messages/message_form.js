Unraveled.Views.MessageForm = Backbone.View.extend({
  events: {
    'click .submit': "submit"
  },

  template: JST['messages/form'],

  render: function () {
    var renderedContent = this.template({

    });
    this.$el.html(renderedContent);

    return this;
  },

  submit: function (even) {
    event.preventDefault();

    var attrs = $(event.target.form).serializeJSON();

    function seccess () {

    }
  }
});