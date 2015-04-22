window.NewsReader = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    if(NewsReader.currentUserId) {
      this._router = new NewsReader.Routers.Router({ $rootEl: $('body') });
      Backbone.history.start();
    }
  }
};

$(document).ready(function(){
  NewsReader.initialize();
});
