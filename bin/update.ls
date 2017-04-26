require! {
  moment, fs
  \prelude-ls : {filter, each, obj-to-pairs}
  \../functions/emergency-quests.ls : main
}

data <- main.get-data
data |> each ->
  it <<<
    iso: it.datetime
    datetime: it.datetime.format "YYYY-MM-DD HH:mm"

formats =
  \events : JSON.stringify _, null, 2
  \events.min : JSON.stringify _
  \quests : (filter (.type is \緊急)) >> JSON.stringify _, null, 2
  \quests.min : (filter (.type is \緊急)) >> JSON.stringify _
|> obj-to-pairs
|> each ([name, fn])->
  data
  |> fn
  |> fs.write-file-sync "#__dirname/../docs/#name.json", _

