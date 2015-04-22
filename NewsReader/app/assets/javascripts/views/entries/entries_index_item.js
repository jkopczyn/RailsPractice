NewsReader.Views.EntriesIndexItem = Backbone.View.extend({

  template: JST['entries/index_item'],
  tagName: "li",

  initialize: function() {
//    this.listenTo(this.model, 'sync change', this.render);
  },

  render: function() {
    this.$el.html(this.template({ entry: this.model }));
    return this;
  }

});
