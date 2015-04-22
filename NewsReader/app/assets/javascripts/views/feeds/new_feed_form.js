NewsReader.Views.NewFeedForm = Backbone.View.extend({
  template: JST['feeds/new_form'],
  tagName: 'form',

  events: {
    'submit': 'submit'
  },

  initialize: function(model, options){
    this.model = new NewsReader.Models.Feed();
  },

  render: function () {
    this.$el.html(this.template({ feed: this.model }));
    return this;
  },

  submit: function(event) {
    event.preventDefault();
    var content = this.$el.serializeJSON();
    this.model.set(content);
    this.model.save([], {
      success: function() {
        this.collection.add(this.model);
      }.bind(this)
    });
  }
});
