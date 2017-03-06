require! {
  moment
}

module.exports = ({it, st}:body)->
  it - st
  |> (* 1_000ms)
  |> moment!.add _, \ms

