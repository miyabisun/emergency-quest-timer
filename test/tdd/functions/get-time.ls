require! {
  chai: {expect}
  \../../../functions/get-time.ls : main
}

filename = __filename.replace(/^.*(test)/, \test)
describe filename, ->
  params = {}
  before (done)!->
    @timeout 5_000ms
    err, res <- main
    params <<< {err, res}
    done!
  specify \is-function ->
    main |> expect >> (.to.be.a \function)
  specify \request-is-done ->
    params.err |> expect >> (.to.be.null)
  specify \is-object ->
    params.res.body |> expect >> (.to.be.a \object)

