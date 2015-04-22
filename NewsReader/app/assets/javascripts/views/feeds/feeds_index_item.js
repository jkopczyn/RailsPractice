NewsReader.Views.FeedsIndexItem = Backbone.View.extend({
  template: JST['feeds/index_item'],
  tagName: 'li',

  events: {
    'click .remove-feed': 'removeFeed'
  },

  render: function () {
    this.$el.html(this.template({ feed: this.model }));
    return this;
  },

  remove: function () {
    this.model.destroy();
    Backbone.View.prototype.remove.call(this);
  },

  removeFeed: function (event) {
    event.preventDefault();
    this.remove();
  }

});
