require! {
  \../functions/get-time.ls
  \../functions/true-time.ls
}

params = {}
refresh = (done)->
  err, time <- get-time
  params.time = time
  done?!
output = ->
  true-time params.time
  |> (.format "HH:mm:ss.S")
  |> ("\r" +)
  |> process.stdout.write _

<- refresh

set-interval output, 50ms
set-interval refresh, 10m * 60_000ms

