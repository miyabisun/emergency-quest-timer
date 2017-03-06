require! {
  chai: {expect}
  \../../../functions/unix-time.ls : main
}

filename = __filename.replace(/^.*(test)/, \test)
describe filename, ->
  specify \is-function ->
    main |> expect >> (.to.be.a \function)
  specify \is-number ->
    main! |> expect >> (.to.be.a \number)
  specify \is-unix-time ->
    main! |> expect >> (.to.be.above 1400000000)
  specify \is-POSIX ->
    main!.to-string! |> expect >> (.to.match /\.\d{3}$/)

