Unraveled.Views.MessageForm = Backbone.View.extend({

  events: {
    'submite form': "submitForm"
  },

  id: "new-message-form",

  initialize: function () {
    this.render();
  },

  template: JST['messages/form'],

  render: function () {
    var renderedContent = this.template({
      friends: this.collection
    });
    this.$el.html(renderedContent);

    return this;
  },

  submitForm: function (even) {
    event.preventDefault();

    var $form = $(event.currentTarget);
    var formData = $form.serializeJSON();

    this.collection.create(formData.message);

    $form[0].reset();

  }
});