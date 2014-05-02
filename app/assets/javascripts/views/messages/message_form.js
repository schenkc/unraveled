Unraveled.Views.MessageForm = Backbone.View.extend({

  events: {
    'submit form': "submitForm"
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

  submitForm: function (event) {
    event.preventDefault();

    var $form = $(event.currentTarget);
    console.log("$form", $form)
    var formData = $form.serializeJSON();
    console.log("forDate", formData)
    this.collection.create(formData.message);

    $form[0].reset();

  }
});