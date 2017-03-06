require! {
  chai: {expect}
  moment
  \prelude-ls : {each}
  \../../../functions/emergency-quests.ls : main
}

filename = __filename.replace(/^.*(test)/, \test)
describe filename, ->
  params = {}
  before (done)!->
    @timeout 5_000ms
    err, html <- main.get-html
    params <<< {err, html}
    done!

  specify \is-object ->
    main |> expect >> (.to.be.a \object)

  describe \get-html ->
    specify \is-string ->
      params.html
      |> expect >> (.to.be.a \string)

  describe \days ->
    specify \is_array ->
      main.days params.html
      |> expect >> (.to.be.a \array)
    specify \children_is_object ->
      main.days params.html
      |> each expect >> (.to.be.a \object)
    specify \children_has_keys ->
      main.days params.html
      |> each expect >> (.to.contain.all.keys <[name table]>)

  describe \hours ->
    specify \is_array ->
      params.html |> main.days >> (.0) |> main.times
      |> expect >> (.to.be.an \array)
    specify \children_is_object ->
      params.html |> main.days >> (.0) |> main.times
      |> each expect >> (.to.be.an \object)

  describe \moment ->
    specify \is_moment_instance ->
      main.moment "12月31日（日）", "23:00"
      |> expect >> (.to.instanceof moment)
    specify \12-31_is_this_year ->
      main.moment "12月31日（日）", "23:00"
      |> (.year!)
      |> expect >> (.to.equal moment!.year!)
    specify \1-1_is_next_year ->
      main.moment "1月1日（日）", "2:00"
      |> (.year!)
      |> expect >> (.to.equal moment!.add(1, \y).year!)

  describe \parse ->
    specify \is_array ->
      main.parse params.html
      |> expect >> (.to.be.an \array)
    specify \children_is_object ->
      main.parse params.html
      |> each expect >> (.to.be.an \object)

