NewsReader.Routers.Router = Backbone.Router.extend({
  initialize: function (options) {
    this.$rootEl = options.$rootEl;
    this._feeds = new NewsReader.Collections.Feeds();
  },

  routes: {
    "": "feedIndex",
    "feeds/:id": "feedShow"
  },

  feedIndex: function () {
    this._feeds.fetch();
    var indexView = new NewsReader.Views.FeedsIndex({
      collection: this._feeds
    });
    this._swapView(indexView);
  },

  feedShow: function (id) {
    var feed = this._feeds.getOrFetch(id);
    var showView = new NewsReader.Views.FeedShow({
      model: feed
    });
    this._swapView(showView);
  },

  _swapView: function(newView) {
    this._currentView && this._currentView.remove();
    this._currentView = newView;
    this.$rootEl.html(newView.render().$el);
  }
});
