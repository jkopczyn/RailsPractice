NewsReader.Views.FeedShow = Backbone.View.extend({
  template: JST["feeds/show"],

  events: {
    'click .refresh': 'refresh'
  },

  refresh: function (event) {
    event.preventDefault();
    this.model.fetch();
  },

  initialize: function() {
    this.listenTo(this.model, "sync", this.render);
  },

  render: function(){
    this.$el.html(this.template({ feed: this.model }));
    var $ul = this.$('.entries-index');
    $ul.empty();
    this.model.entries().each(function (entry) {
      var entryView = new NewsReader.Views.EntriesIndexItem({
        model: entry
      });
      $ul.append(entryView.render().$el);
    });
    return this;
  }
});
