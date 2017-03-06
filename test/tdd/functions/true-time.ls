require! {
  chai: {expect}
  moment
  \../../../functions/get-time.ls
  \../../../functions/true-time.ls : main
}

filename = __filename.replace(/^.*(test)/, \test)
describe filename, ->
  specify \is-function ->
    main |> expect >> (.to.be.a \function)
  specify \is-moment (done)!->
    @timeout 5_000ms
    _, {body} <- get-time
    main body |> expect >> (.to.instanceof moment)
    done!

