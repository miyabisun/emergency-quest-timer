require! {
  chai: {expect}
  moment
  \prelude-ls : {each}
  \../../../functions/events-url.ls : main
}

filename = __filename.replace(/^.*(test)/, \test)
describe filename, ->
  specify \is-object ->
    main |> expect >> (.to.be.a \object)

  describe \get-url ->
    params = {}
    before (done)!->
      @timeout 5_000ms
      url <- main.get-url
      params <<< {url}
      done!
    specify \is_string ->
      params.url |> expect >> (.to.be.a \string)
    specify \is_url ->
      params.url |> expect >> (.to.match /^https?:\/\//)

  describe \get-rss ->
    params = {}
    before (done)!->
      @timeout 5_000ms
      rss <- main.get-rss
      params <<< {rss}
      done!
    specify \is_array ->
      params.rss |> expect >> (.to.be.an \array)
    specify \children_is_object ->
      params.rss |> each expect >> (.to.be.a \object)
    specify.skip \output-title-link ->
      params.rss |> each ({title})->
        console.log title

  describe \event-url ->
    params = {}
    before (done)!->
      @timeout 5_000ms
      rss <- main.get-rss
      params <<< {rss}
      done!
    specify \is_string ->
      main.event-url-of params.rss
      |> expect >> (.to.be.a \string)

