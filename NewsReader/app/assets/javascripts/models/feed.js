NewsReader.Models.Feed = Backbone.Model.extend({
  urlRoot: "api/feeds",

  entries: function (collection) {
    if(this._entries) {
      if(collection) {
        this._entries.add(collection);
      }
      return this._entries;
    } else {
      return this._entries = new NewsReader.Collections.Entries(
        collection, { feed: this }
      );
    }
  },

  parse: function(data, options) {
    var entries = data.latest_entries;
    if( data.latest_entries) {
      delete data.latest_entries;
    }
    this.entries(entries);
    return data;
  }

});
