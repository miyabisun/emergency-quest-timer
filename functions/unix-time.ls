require! {
  moment
}

module.exports = ->
  moment!.format \x |> (/ 1_000ms)

