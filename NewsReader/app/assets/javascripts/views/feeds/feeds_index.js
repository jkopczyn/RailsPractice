NewsReader.Views.FeedsIndex = Backbone.View.extend({
  initialize: function (option) {
    this.listenTo(this.collection, "sync remove add", this.render);
  },

  template: JST['feeds/index'],

  render: function () {
    var content = this.template();
    this.$el.html(content);
    var $ul = this.$('.feeds-index');
    $ul.empty();
    this.collection.each(function (feed) {
      var feedView = new NewsReader.Views.FeedsIndexItem({ model: feed });
      $ul.append(feedView.render().$el);
    });

    var formView = new NewsReader.Views.NewFeedForm({
      collection: this.collection
    });
    this.$('.new-feed').html(formView.render().$el);

    return this;
  },


});
