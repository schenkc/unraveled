Unraveled.Collections.Messages = Backbone.Collection.extend({

  model: Unraveled.Models.Message,
  url: '/api/messages',
  comparator: 'created_at',


});