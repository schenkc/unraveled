Unraveled.Views.MessageForm = Backbone.View.extend({

  events: {
    'submit form': "submitForm"
  },

  id: "new-message-form",

  initialize: function (options) {
    this.friends = options.friends
    this.collection = options.collection
    this.model = options.model
    this.render();
  },

  template: JST['messages/form'],

  render: function () {
    var renderedContent = this.template({
      friends: this.friends
    });
    this.$el.html(renderedContent);

    return this;
  },

  submitForm: function (event) {
    event.preventDefault();

    var $form = $(event.currentTarget);
    var formData = $form.serializeJSON();
    console.log(this.collection)
    this.collection.create(formData.message);

    $form[0].reset();
    console.log(this);
    this.collection.sort();
    Backbone.history.navigate("", {trigger: true});

  }
});