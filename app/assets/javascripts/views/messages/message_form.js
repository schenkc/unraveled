Unraveled.Views.MessageForm = Backbone.View.extend({

  events: {
    'submit form': "submitForm"
  },

  id: "new-message-form",

  initialize: function (options) {
    this.friends = options.friends
    this.collection = options.collection
    this.model = options.model
    this.defaultFriend = options.defaultFriend
    this.render();
  },

  template: JST['messages/form'],

  render: function () {
    var renderedContent = this.template({
      friends: this.friends,
      defaultFriend: this.defaultFriend
    });

    this.$el.html(renderedContent);

    return this;
  },

  submitForm: function (event) {
    event.preventDefault();

    var $form = $(event.currentTarget);
    var formData = $form.serializeJSON();

    this.collection.create(formData.message);

    $form[0].reset();
    this.collection.sort();
    Backbone.history.navigate("", {trigger: true});

  }
});