require! {
  request
  feedparser: FeedParser
  \../config/events-rss.json : feed
  \prelude-ls : {find}
}

module.exports =
  get-url: (cb)->
    feeds <~ @get-rss
    cb @event-url-of feeds
  get-rss: (cb)->
    feedparser = new FeedParser {}
    items = []
    request feed
      .on \response (res)-> @pipe feedparser
    feedparser
      ..on \readable ->
        while item = @read!
          items.push item
      ..on \end ->
        cb items
  event-url-of: (feeds)->
    feeds
    |> find (.title is /予告イベント情報/)
    |> (or {})
    |> (.link)

